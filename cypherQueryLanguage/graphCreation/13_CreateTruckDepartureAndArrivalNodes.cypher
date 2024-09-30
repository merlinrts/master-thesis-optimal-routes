// Define the start datetime and set the number of days
WITH localdatetime({
    year: 2024, month: 1, day: 1, 
    hour: 10, minute: 0, second: 0}) 
    AS startDate, 100 AS days

// Match all existing Location nodes
MATCH (location:Location)
WITH location, startDate, days

// For each timestamp, create a TimeExpandedTruckArrival node with an incremented timestamp
UNWIND range(0, days - 1) AS i
WITH 
    location, startDate, 
    startDate + duration({days: i}) AS timestamp

// Create or match the TimeExpandedTruckDeparture node for each day and connect it to the Location
MERGE (timeExpandedTruckDeparture:TimeExpandedTruckDeparture {
    locode: location.locode, 
    timestamp: timestamp, 
    lat:location.lat, 
    lon:location.lon})

MERGE 
    (location)
    -[:HAS_TIME_EXPANDED_TRUCK_DEPARTURE]->
    (timeExpandedTruckDeparture)

// Create or match the TimeExpandedTruckArrival node for each day and connect it to the Location
MERGE (timeExpandedTruckArrival:TimeExpandedTruckArrival {
    locode: location.locode, 
    timestamp: timestamp, 
    lat:location.lat, 
    lon:location.lon})

MERGE 
    (location)
    -[:HAS_TIME_EXPANDED_TRUCK_ARRIVAL]->
    (timeExpandedTruckArrival);