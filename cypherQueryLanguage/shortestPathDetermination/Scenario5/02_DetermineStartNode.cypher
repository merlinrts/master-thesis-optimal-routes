MATCH
    (voyage:Voyage {voyageId: 1200})
    <-[:IS_PART_OF]-
    (vesselArrival:VesselArrival)
    -[:VESSEL_DISCHARGE]->
    (timeExpandedTerminal:TimeExpandedTerminal)
    <-[:IS_TIME_EXPANDED_TO]-
    (:Terminal {terminalCode: "USNYC-ST"})
RETURN DISTINCT(vesselArrival)