// MATCH old connection
MATCH 
    (vesselDeparture:VesselDeparture)
    -[oldVesselLeg:VESSEL_LEG]->
    (oldVesselArrival:VesselArrival {voyageId: 1})
    -[oldVesselDischarge:VESSEL_DISCHARGE]->
    (oldTimeExpandedTerminal:TimeExpandedTerminal)
    <-[:IS_TIME_EXPANDED_TO]-
    (:Terminal {terminalCode: "USORF-ST"})

// MATCH new Terminal
MATCH
    (newTerminal:Terminal {terminalCode: "USNYC-ST"})
    -[:IS_TIME_EXPANDED_TO]->
    (newTimeExpandedTerminal:TimeExpandedTerminal {
        timestamp:localdatetime("2024-02-08T10:00:00")})

// DELETE old connection and the old arrival node
DELETE oldVesselDischarge, oldVesselLeg
DELETE oldVesselArrival

// CREATE new Arrival node
CREATE (newVesselArrival:VesselArrival {
    timestamp: localdatetime("2024-02-07T10:00:00"), 
    terminalCode: newTerminal.terminalCode,
    lat: newTerminal.lat,
    lon: newTerminal.lon,
    id: 9999,
    voyageId: 1
})

// CREATE new Vessel Leg relationship
CREATE (vesselDeparture)-[newVesselLeg:VESSEL_LEG {
    containerType: "22G1", 
    freightType: "GENERAL",
    costs: 100,
    kgCO2e: 10,
    transshipment: true,
    duration: duration.inSeconds(
         vesselDeparture.timestamp, 
         newVesselArrival.timestamp
     ).hours
}]->(newVesselArrival)

// CREATE new Discharge relationship
CREATE (newVesselArrival)-[newVesselDischarge:VESSEL_DISCHARGE {
    containerType: "22G1", 
    freightType: "GENERAL",
    costs: 100,
    kgCO2e: 1,
    transshipment: true,
    duration: duration.inSeconds(
         vesselDeparture.timestamp, 
         newVesselArrival.timestamp
     ).hours
}]->(newTimeExpandedTerminal)

// RETURN to confirm the changes
RETURN newVesselArrival, newVesselLeg, newVesselDischarge;