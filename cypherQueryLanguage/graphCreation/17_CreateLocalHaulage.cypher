LOAD CSV WITH HEADERS FROM 'file:///local_haulage.csv' AS row

MATCH
    (location:Location {locode: row.locode})
    -[:HAS_TIME_EXPANDED_TRUCK_DEPARTURE]->
    (timeExpandedTruckDeparture:TimeExpandedTruckDeparture)

MATCH
    (location:Location {locode: row.locode})
    -[:HAS_TIME_EXPANDED_TRUCK_ARRIVAL]->
    (timeExpandedTruckArrival:TimeExpandedTruckArrival {
        timestamp: timeExpandedTruckDeparture.timestamp 
            + duration({hours: toInteger(row.duration)})})

CREATE (timeExpandedTruckDeparture)-[:LOCAL_HAULAGE {
    kgCO2e: toInteger(row.kgCO2e),
    containerType: row.containerType,
    freightType: row.freightType,
    costs: toInteger(row.costs),
    contractor: row.contractor,
    transshipment: false
}]->(timeExpandedTruckArrival);