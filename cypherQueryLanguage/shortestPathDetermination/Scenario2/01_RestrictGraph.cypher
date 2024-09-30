// Restrict every rail leg that starts or ends
// in the US and has a departure timestamp
// after 2024-01-01T10:00:00 and an arrival
// timestamp before 2024-03-01T10:00:00
MATCH 
    (startCountry:Country)
    -[:HAS_CHILD]->
    (:Region)
    -[:HAS_CHILD]->
    (:Location)
    -[:HAS_CHILD]->
    (:Terminal)
    -[:IS_TIME_EXPANDED_TO]->
    (:TimeExpandedTerminal)
    -[:RAIL_LIFT_ON]->
    (railDeparture:RailDeparture)
    -[r:RAIL_LEG]->
    (railArrival:RailArrival)
    -[:RAIL_LIFT_OFF]->
    (:TimeExpandedTerminal)
    <-[:IS_TIME_EXPANDED_TO]-
    (:Terminal)
    <-[:HAS_CHILD]-
    (:Location)
    <-[:HAS_CHILD]-
    (:Region)
    <-[:HAS_CHILD]-
    (endCountry:Country)

WHERE (startCountry.countryCode = 'US'
    OR endCountry.countryCode = 'US')
    AND railDeparture.timestamp 
        >= localdatetime("2024-01-01T10:00:00")
    AND railArrival.timestamp 
        < localdatetime("2024-03-01T10:00:00")
WITH DISTINCT r
SET r.isRestricted = true;