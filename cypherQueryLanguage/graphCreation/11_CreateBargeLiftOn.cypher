LOAD CSV WITH HEADERS FROM 'file:///lift_on_inland.csv' AS row

MATCH (departureTerminal:Terminal {terminalCode: row.terminalCode})
    -[:IS_TIME_EXPANDED_TO]->
    (timeExpandedDepartureTerminal:TimeExpandedTerminal)

MATCH (bargeDeparture:BargeDeparture {
    timestamp: timeExpandedDepartureTerminal.timestamp, 
    terminalCode: departureTerminal.terminalCode
})

// Create LIFT_ON Relationship
CREATE (timeExpandedDepartureTerminal)-[:BARGE_LIFT_ON {
    costs: toInteger(row.costs), 
    kgCO2e: toInteger(row.kgCO2e),
    containerType: row.containerType,
    freightType: row.freightType,
    transshipment: false
}]->(bargeDeparture);