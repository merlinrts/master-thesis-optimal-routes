MATCH 
    (startTerminal:Terminal {terminalCode: "DEHAM-ST"})
    -[:IS_TIME_EXPANDED_TO]->
    (timeExpandedDepartureTerminal:TimeExpandedTerminal {timestamp: localdatetime("2024-02-01T10:00:00")})

WITH startTerminal, timeExpandedDepartureTerminal

MATCH
    (timeExpandedArrivalTerminal:TimeExpandedTerminal {timestamp: localdatetime("2024-02-08T10:00:00")})
    <-[:IS_TIME_EXPANDED_TO]-
    (endTerminal:Terminal {terminalCode: "USORF-ST"})

CREATE (vesselDeparture:VesselDeparture {
    timestamp: localdatetime("2024-02-02T10:00:00"), 
    terminalCode: startTerminal.terminalCode,
    lat: startTerminal.lat,
    lon: startTerminal.lon,
    id: 9998,
    voyageId: 1
})

CREATE (vesselArrival:VesselArrival {
    timestamp: localdatetime("2024-02-07T10:00:00"), 
    terminalCode: endTerminal.terminalCode,
    lat: endTerminal.lat,
    lon: endTerminal.lon,
    id: 9999,
    voyageId: 1
})

CREATE (vesselDeparture)-[vesselLeg:VESSEL_LEG {
    kgCO2e: 10, 
    costs: 1000, 
    containerType: "22G1", 
    freightType: "GENERAL",
    transshipment: false,
    duration: duration.inSeconds(
        vesselDeparture.timestamp, 
        vesselArrival.timestamp).hours
}]->(vesselArrival)

CREATE (timeExpandedDepartureTerminal)-[vesselLoad:VESSEL_LOAD {
    containerType: "22G1", 
    freightType: "GENERAL",
    costs: 100,
    kgCO2e: 1,
    transshipment: false,
    duration: duration.inSeconds(
        timeExpandedDepartureTerminal.timestamp, 
        vesselDeparture.timestamp).hours
}]->(vesselDeparture)

CREATE (vesselArrival)-[vesselDischarge:VESSEL_DISCHARGE {
    containerType: "22G1", 
    freightType: "GENERAL",
    costs: 100,
    kgCO2e: 1,
    transshipment: true,
    duration: duration.inSeconds(
        vesselArrival.timestamp, 
        timeExpandedArrivalTerminal.timestamp).hours
}]->(timeExpandedArrivalTerminal)

RETURN vesselLoad, vesselDeparture, vesselLeg, vesselArrival, vesselDischarge;