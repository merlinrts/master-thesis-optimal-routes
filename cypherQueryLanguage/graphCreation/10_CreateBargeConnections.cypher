LOAD CSV WITH HEADERS FROM 'file:///barge_routes.csv' AS row

// Find TE Departure Terminal (at departure)
MATCH (departureTerminal:Terminal {terminalCode: row.startTerminal})
    -[:IS_TIME_EXPANDED_TO]->
    (timeExpandedDepartureTerminal:TimeExpandedTerminal {timestamp: localdatetime(row.departure)})

// Find TE Arrival Terminal (at arrival)
MATCH (arrivalTerminal:Terminal {terminalCode: row.endTerminal})
    -[:IS_TIME_EXPANDED_TO]->
    (timeExpandedArrivalTerminal:TimeExpandedTerminal {timestamp: localdatetime(row.arrival)})

// Create Barge Departure Node (one per leg)
MERGE (bargeDeparture:BargeDeparture {
    timestamp: localdatetime(row.departure), 
    terminalCode: departureTerminal.terminalCode,
    lat: departureTerminal.lat,
    lon: departureTerminal.lon,
    id: toInteger(row.legId)
})

// Create Barge Arrival Node (one per leg)
MERGE (bargeArrival:BargeArrival {
    timestamp: localdatetime(row.arrival), 
    terminalCode: arrivalTerminal.terminalCode,
    lat: arrivalTerminal.lat,
    lon: arrivalTerminal.lon,
    id: toInteger(row.legId)
})

// Create Barge Connection Relationship
CREATE (bargeDeparture)-[:BARGE_LEG {
    kgCO2e: toInteger(row.kgCO2e), 
    costs: toInteger(row.costs), 
    containerType: row.containerType, 
    freightType: row.freightType,
    transshipment: false
}]->(bargeArrival)

// Match Previously departure
WITH row, bargeDeparture
OPTIONAL MATCH (previousArrival:BargeArrival {id: toInteger(row.previousLegId)})
WITH row, previousArrival, bargeDeparture
WHERE previousArrival IS NOT NULL

// Previous Barge Arrival -(REMN)-> Barge Departure
MERGE (previousArrival)-[:REMAIN_ON_BARGE {
    kgCO2e: toInteger(row.kgCO2e), 
    costs: toInteger(row.costs), 
    containerType: row.containerType, 
    freightType: row.freightType,
    transshipment: false
}]->(bargeDeparture)

RETURN count(previousArrival);