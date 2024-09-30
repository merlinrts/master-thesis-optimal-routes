MATCH 
    (startLocation:Location)
    -[:HAS_TIME_EXPANDED_TRUCK_DEPARTURE]->
    (timeExpandedTruckDeparture:TimeExpandedTruckDeparture)
    -[:TRUCK_LEG]->
    (timeExpandedTruckArrival:TimeExpandedTruckArrival)
    <-[:HAS_TIME_EXPANDED_TRUCK_ARRIVAL]-
    (endLocation:Location)

RETURN DISTINCT 
    startLocation.locode, 
    endLocation.locode, 
    duration.between(
        timeExpandedTruckDeparture.timestamp, 
        timeExpandedTruckArrival.timestamp) AS duration, 
    MIN(timeExpandedTruckDeparture.timestamp) AS validFrom,
    MAX(timeExpandedTruckArrival.timestamp) AS validTo;