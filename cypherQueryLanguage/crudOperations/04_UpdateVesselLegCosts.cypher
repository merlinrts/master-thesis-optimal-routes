MATCH 
    (vesselDeparture:VesselDeparture {id: 9998})
    -[vesselLeg:VESSEL_LEG]->
    (vesselArrival:VesselArrival {id: 9999})
SET vesselLeg.costs = 100

RETURN vesselLeg;