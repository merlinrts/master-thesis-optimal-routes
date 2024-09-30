LOAD CSV WITH HEADERS FROM 'file:///lift_on_inland.csv' AS row

MATCH
(liftOnTerminal:TimeExpandedTerminal {terminalCode: row.terminalCode})
<-[:IS_TIME_EXPANDED_TO]-(:Terminal)
<-[:HAS_CHILD]-(:Location)
-[:HAS_TIME_EXPANDED_TRUCK_DEPARTURE]->(timeExpandedTruckDeparture:TimeExpandedTruckDeparture {timestamp:liftOnTerminal.timestamp})

// Create LIFT_ON Relationship
CREATE (liftOnTerminal)-[:TRUCK_LIFT_ON {
    costs: toInteger(row.costs), 
    kgCO2e: toInteger(row.kgCO2e),
    containerType: row.containerType,
    freightType: row.freightType,
    transshipment: false
}]->(timeExpandedTruckDeparture);