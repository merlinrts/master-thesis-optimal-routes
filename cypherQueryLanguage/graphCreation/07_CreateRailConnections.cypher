LOAD CSV WITH HEADERS FROM 'file:///rail_routes.csv' AS row

// Find TE Departure Terminal (at departure)
MATCH (departureTerminal:Terminal {terminalCode: row.startTerminal})
    -[:IS_TIME_EXPANDED_TO]->
    (timeExpandedDepartureTerminal:TimeExpandedTerminal {timestamp: localdatetime(row.departure)})

// Find TE Arrival Terminal (at arrival)
MATCH (arrivalTerminal:Terminal {terminalCode: row.endTerminal})
    -[:IS_TIME_EXPANDED_TO]->
    (timeExpandedArrivalTerminal:TimeExpandedTerminal {timestamp: localdatetime(row.arrival)})

// Create Rail Departure Node (one per leg)
MERGE (railDeparture:RailDeparture {
    timestamp: localdatetime(row.departure), 
    terminalCode: departureTerminal.terminalCode,
    lat: departureTerminal.lat,
    lon: departureTerminal.lon,
    id: toInteger(row.legId)
})

// Create Rail Arrival Node (one per leg)
MERGE (railArrival:RailArrival {
    timestamp: localdatetime(row.arrival), 
    terminalCode: arrivalTerminal.terminalCode,
    lat: arrivalTerminal.lat,
    lon: arrivalTerminal.lon,
    id: toInteger(row.legId)
})

// Create Rail Connection Relationship
CREATE (railDeparture)-[:RAIL_LEG {
    kgCO2e: toInteger(row.kgCO2e), 
    costs: toInteger(row.costs), 
    containerType: row.containerType, 
    freightType: row.freightType,
    transshipment: false
}]->(railArrival)

// Match Previously departure
WITH row, railDeparture
OPTIONAL MATCH (previousArrival:RailArrival {id: toInteger(row.previousLegId)})
WITH row, previousArrival, railDeparture
WHERE previousArrival IS NOT NULL

// Previous Rail Arrival -(REMN)-> Rail Departure
MERGE (previousArrival)-[:REMAIN_ON_RAIL {
    kgCO2e: toInteger(row.kgCO2e), 
    costs: toInteger(row.costs), 
    containerType: row.containerType, 
    freightType: row.freightType,
    transshipment: false
}]->(railDeparture)

RETURN count(previousArrival);
