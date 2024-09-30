LOAD CSV WITH HEADERS FROM 'file:///vessel_routes.csv' AS row

// Find TE Departure Terminal (at cut-off) 
// Supported by terminal_code_index and time_expanded_terminal_index
MATCH 
    (departureTerminal:Terminal {
        terminalCode: row.startTerminal})
    -[:IS_TIME_EXPANDED_TO]->
    (timeExpandedDepartureTerminal:TimeExpandedTerminal {
        timestamp: localdatetime(row.cutOff)})

// Find TE Arrival Terminal (at pick-up)
// Supported by terminal_code_index and time_expanded_terminal_index
MATCH 
    (arrivalTerminal:Terminal {
        terminalCode: row.endTerminal})
    -[:IS_TIME_EXPANDED_TO]->
    (timeExpandedArrivalTerminal:TimeExpandedTerminal {
        timestamp: localdatetime(row.pickUp)})

// Create Vessel Departure Node
// One per leg, therefore MERGE is used
MERGE (vesselDeparture:VesselDeparture {
    timestamp: localdatetime(row.departure), 
    terminalCode: departureTerminal.terminalCode,
    lat: departureTerminal.lat,
    lon: departureTerminal.lon,
    id: toInteger(row.legId),
    voyageId: toInteger(row.voyageId)
})

// Create Vessel Arrival Node
// One per leg, therefore MERGE is used
MERGE (vesselArrival:VesselArrival {
    timestamp: localdatetime(row.arrival), 
    terminalCode: arrivalTerminal.terminalCode,
    lat: arrivalTerminal.lat,
    lon: arrivalTerminal.lon,
    id: toInteger(row.legId),
    voyageId: toInteger(row.voyageId)
})

// Create :VESSEL_LEG
CREATE (vesselDeparture)-[:VESSEL_LEG {
    kgCO2e: toInteger(row.kgCO2e), 
    costs: toInteger(row.costs), 
    containerType: row.containerType, 
    freightType: row.freightType,
    transshipment: false
}]->(vesselArrival)

// Vessel Load
// Properties will be assigned in next step
WITH 
    row, timeExpandedDepartureTerminal, vesselDeparture, 
    vesselArrival, timeExpandedArrivalTerminal
MERGE (timeExpandedDepartureTerminal)-[:VESSEL_LOAD {
    containerType: row.containerType, 
    freightType: row.freightType
}]->(vesselDeparture)

// Vessel Discharge
// Properties will be assigned in next step
WITH 
    row, vesselArrival, timeExpandedArrivalTerminal, 
    vesselDeparture
MERGE (vesselArrival)-[:VESSEL_DISCHARGE {
    containerType: row.containerType, 
    freightType: row.freightType
}]->(timeExpandedArrivalTerminal)

// Possibility to remain on vessel
// MATCH previous arrival node
WITH row, vesselDeparture
OPTIONAL MATCH 
    (previousArrival:VesselArrival {
        id: toInteger(row.previousLegId)})
WITH row, previousArrival, vesselDeparture
WHERE previousArrival IS NOT NULL

// Create :REMAIN_ON_VESSEL relationship
MERGE (previousArrival)-[:REMAIN_ON_VESSEL {
    kgCO2e: toInteger(row.kgCO2e), 
    costs: toInteger(row.costs), 
    containerType: row.containerType, 
    freightType: row.freightType,
    transshipment: false
}]->(vesselDeparture);
