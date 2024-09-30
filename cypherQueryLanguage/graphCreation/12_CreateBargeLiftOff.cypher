LOAD CSV WITH HEADERS FROM 'file:///lift_off_inland.csv' AS row

MATCH (arrivalTerminal:Terminal {terminalCode: row.terminalCode})
    -[:IS_TIME_EXPANDED_TO]->
    (timeExpandedArrivalTerminal:TimeExpandedTerminal)

MATCH (bargeArrival:BargeArrival {
    timestamp: timeExpandedArrivalTerminal.timestamp, 
    terminalCode: arrivalTerminal.terminalCode
})

// Create LIFT_ON Relationship
CREATE (bargeArrival)-[:BARGE_LIFT_OFF {
    costs: toInteger(row.costs), 
    kgCO2e: toInteger(row.kgCO2e),
    containerType: row.containerType,
    freightType: row.freightType,
    transshipment: true
}]->(timeExpandedArrivalTerminal);