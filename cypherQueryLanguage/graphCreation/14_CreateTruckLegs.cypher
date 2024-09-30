LOAD CSV WITH HEADERS FROM 'file:///truck_routes.csv' AS row

MATCH (departureLocation:Location {locode: row.startLocode})
    -[:HAS_TIME_EXPANDED_TRUCK_DEPARTURE]->
    (timeExpandedTruckDeparture:TimeExpandedTruckDeparture)

WITH row, timeExpandedTruckDeparture

MATCH (arrivalLocation:Location {locode: row.endLocode})
    -[r:HAS_TIME_EXPANDED_TRUCK_ARRIVAL]->
    (timeExpandedTruckArrival:TimeExpandedTruckArrival {
        timestamp: timeExpandedTruckDeparture.timestamp 
            + duration({hours: toInteger(row.duration)})})

WITH row, timeExpandedTruckDeparture, timeExpandedTruckArrival

CREATE (timeExpandedTruckDeparture)-[:TRUCK_LEG {
    kgCO2e: toInteger(row.kgCO2e),
    containerType: row.containerType,
    freightType: row.freightType,
    costs: toInteger(row.costs),
    contractor: row.contractor,
    transshipment: false
}]->(timeExpandedTruckArrival);
