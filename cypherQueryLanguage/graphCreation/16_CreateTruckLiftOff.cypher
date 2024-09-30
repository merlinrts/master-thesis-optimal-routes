LOAD CSV WITH HEADERS FROM 'file:///lift_off_inland.csv' AS row

MATCH
(liftOffTerminal:TimeExpandedTerminal {terminalCode: row.terminalCode})
<-[:IS_TIME_EXPANDED_TO]-(:Terminal)
<-[:HAS_CHILD]-(:Location)
-[:HAS_TIME_EXPANDED_TRUCK_ARRIVAL]->(timeExpandedTruckArrival:TimeExpandedTruckArrival {timestamp:liftOffTerminal.timestamp})

// Create LIFT_ON Relationship
CREATE (timeExpandedTruckArrival)-[:TRUCK_LIFT_OFF {
    costs: toInteger(row.costs), 
    kgCO2e: toInteger(row.kgCO2e),
    containerType: row.containerType,
    freightType: row.freightType,
    transshipment: true
}]->(liftOffTerminal);