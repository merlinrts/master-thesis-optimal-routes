// Countries
MATCH (country:Country)
WITH count(country) AS nodeCount
CALL apoc.util.validate(nodeCount <> 5, 'Count of Country nodes is not 5', []) 
RETURN nodeCount;

// Regions
MATCH (region:Region)
WITH count(region) AS nodeCount
CALL apoc.util.validate(nodeCount <> 7, 'Count of Region nodes is not 7', []) 
RETURN nodeCount;

// Locations
MATCH (location:Location)
WITH count(location) AS nodeCount
CALL apoc.util.validate(nodeCount <> 10, 'Count of Location nodes is not 10', []) 
RETURN nodeCount;

// Terminals
MATCH (terminal:Terminal)
WITH count(terminal) AS nodeCount
CALL apoc.util.validate(nodeCount <> 10, 'Count of Terminal nodes is not 10', []) 
RETURN nodeCount;

// Geographical Structure Relationships
MATCH ()-[r:HAS_CHILD]->()
WITH count(r) AS relationshipCount
CALL apoc.util.validate(relationshipCount <> 27, 'Count of HAS_CHILD relationships is not 27', [])
RETURN relationshipCount;

// Time Expand Terminals
MATCH (timeExpandedTerminal:TimeExpandedTerminal)
WITH count(timeExpandedTerminal) AS nodeCount
CALL apoc.util.validate(nodeCount <> 1000, 'Count of TimeExpandedTerminal nodes is not 1000', []) 
RETURN nodeCount;

// IS_TIME_EXPANDED_TO Relationships
MATCH ()-[isTimeExpandedTo:IS_TIME_EXPANDED_TO]->()
WITH count(isTimeExpandedTo) AS nodeCount
CALL apoc.util.validate(nodeCount <> 1000, 'Count of IS_TIME_EXPANDED_TO relationships is not 1000', []) 
RETURN nodeCount;

// HAS_DIRECT_SUCCESSOR Relationships
MATCH ()-[hasDirectSuccessor:HAS_DIRECT_SUCCESSOR]->()
WITH count(hasDirectSuccessor) AS nodeCount
CALL apoc.util.validate(nodeCount <> 990, 'Count of HAS_DIRECT_SUCCESSOR relationships is not 990', []) 
RETURN nodeCount;

// WAIT_AT_TERMINAL Relationships
MATCH ()-[waitAtTerminal:WAIT_AT_TERMINAL]->()
WITH count(waitAtTerminal) AS nodeCount
CALL apoc.util.validate(nodeCount <> 4950, 'Count of WAIT_AT_TERMINAL relationships is not 4950', []) 
RETURN nodeCount;

// Vessel Connections - Vessel Departure
MATCH (vesselDeparture:VesselDeparture)
WITH count(vesselDeparture) AS nodeCount
CALL apoc.util.validate(nodeCount <> 105, 'Count of VesselDeparture nodes is not 105', []) 
RETURN nodeCount;

// Vessel Connections - Vessel Arrival
MATCH (vesselArrival:VesselArrival)
WITH count(vesselArrival) AS nodeCount
CALL apoc.util.validate(nodeCount <> 105, 'Count of VesselArrival nodes is not 105', []) 
RETURN nodeCount;

// VESSEL_LEG Relationships
MATCH ()-[vesselConnection:VESSEL_LEG]->()
WITH count(vesselConnection) AS nodeCount
CALL apoc.util.validate(nodeCount <> 525, 'Count of VESSEL_LEG relationships is not 525', []) 
RETURN nodeCount;

// VESSEL_LOAD Relationships
MATCH ()-[vesselLoad:VESSEL_LOAD]->()
WITH count(vesselLoad) AS nodeCount
CALL apoc.util.validate(nodeCount <> 525, 'Count of VESSEL_LOAD relationships is not 525', []) 
RETURN nodeCount;

// VESSEL_DISCHARGE Relationships
MATCH ()-[vesselDischarge:VESSEL_DISCHARGE]->()
WITH count(vesselDischarge) AS nodeCount
CALL apoc.util.validate(nodeCount <> 525, 'Count of VESSEL_DISCHARGE relationships is not 525', []) 
RETURN nodeCount;

// REMAIN_ON_VESSEL Relationships
MATCH ()-[remainOnVessel:REMAIN_ON_VESSEL]->()
WITH count(remainOnVessel) AS nodeCount
CALL apoc.util.validate(nodeCount <> 485, 'Count of REMAIN_ON_VESSEL relationships is not 485', []) 
RETURN nodeCount;

// Rail Departure
MATCH (railDeparture:RailDeparture)
WITH count(railDeparture) AS nodeCount
CALL apoc.util.validate(nodeCount <> 164, 'Count of RailDeparture nodes is not 164', []) 
RETURN nodeCount;

// Rail Arrival
MATCH (railArrival:RailArrival)
WITH count(railArrival) AS nodeCount
CALL apoc.util.validate(nodeCount <> 164, 'Count of RailArrival nodes is not 164', []) 
RETURN nodeCount;

// RAIL_LEG Relationships
MATCH ()-[railConnection:RAIL_LEG]->()
WITH count(railConnection) AS nodeCount
CALL apoc.util.validate(nodeCount <> 820, 'Count of RAIL_LEG relationships is not 820', []) 
RETURN nodeCount;

// REMAIN_ON_RAIL Relationships
MATCH ()-[remainOnRail:REMAIN_ON_RAIL]->()
WITH count(remainOnRail) AS nodeCount
CALL apoc.util.validate(nodeCount <> 260, 'Count of REMAIN_ON_RAIL relationships is not 260', [])
RETURN nodeCount;

// RAIL_LIFT_ON Relationships
MATCH ()-[railLoad:RAIL_LIFT_ON]->()
WITH count(railLoad) AS nodeCount
CALL apoc.util.validate(nodeCount <> 820, 'Count of RAIL_LOAD relationships is not 820', []) 
RETURN nodeCount;

// RAIL_LIFT_OFF Relationships
MATCH ()-[railDischarge:RAIL_LIFT_OFF]->()
WITH count(railDischarge) AS nodeCount
CALL apoc.util.validate(nodeCount <> 820, 'Count of RAIL_DISCHARGE relationships is not 820', []) 
RETURN nodeCount;

// Barge Departure
MATCH (bargeDeparture:BargeDeparture)
WITH count(bargeDeparture) AS nodeCount
CALL apoc.util.validate(nodeCount <> 28, 'Count of BargeDeparture nodes is not 28', []) 
RETURN nodeCount;

// Barge Arrival
MATCH (bargeArrival:BargeArrival)
WITH count(bargeArrival) AS nodeCount
CALL apoc.util.validate(nodeCount <> 28, 'Count of BargeArrival nodes is not 28', []) 
RETURN nodeCount;

// BARGE_LEG Relationships
MATCH ()-[bargeConnection:BARGE_LEG]->()
WITH count(bargeConnection) AS nodeCount
CALL apoc.util.validate(nodeCount <> 140, 'Count of BARGE_LEG relationships is not 140', []) 
RETURN nodeCount;

// REMAIN_ON_BARGE Relationships
MATCH ()-[remainOnBarge:REMAIN_ON_BARGE]->()
WITH count(remainOnBarge) AS nodeCount
CALL apoc.util.validate(nodeCount <> 0, 'Count of REMAIN_ON_BARGE relationships is not 0', [])
RETURN nodeCount;

// BARGE_LIFT_ON Relationships
MATCH ()-[bargeLoad:BARGE_LIFT_ON]->()
WITH count(bargeLoad) AS nodeCount
CALL apoc.util.validate(nodeCount <> 140, 'Count of BARGE_LOAD relationships is not 140', []) 
RETURN nodeCount;

// BARGE_LIFT_OFF Relationships
MATCH ()-[bargeDischarge:BARGE_LIFT_OFF]->()
WITH count(bargeDischarge) AS nodeCount
CALL apoc.util.validate(nodeCount <> 140, 'Count of BARGE_DISCHARGE relationships is not 140', []) 
RETURN nodeCount;

// Time Expanded Truck Departure
MATCH (timeExpandedTruckDeparture:TimeExpandedTruckDeparture)
WITH count(timeExpandedTruckDeparture) AS nodeCount
CALL apoc.util.validate(nodeCount <> 1000, 'Count of TimeExpandedTruckDeparture nodes is not 1000', [])
RETURN nodeCount;

// Time Expanded Truck Arrival
MATCH (timeExpandedTruckArrival:TimeExpandedTruckArrival)
WITH count(timeExpandedTruckArrival) AS nodeCount
CALL apoc.util.validate(nodeCount <> 1000, 'Count of TimeExpandedTruckArrival nodes is not 1000', [])
RETURN nodeCount;

// TRUCK_LEG Relationships
MATCH ()-[truckLeg:TRUCK_LEG]->()
WITH count(truckLeg) AS relCount
CALL apoc.util.validate(relCount <> 4950, 'Count of TRUCK_LEG relationships is not 4950', [])
RETURN relCount;

// LOCAL_HAULAGE Relationship
MATCH ()-[localHaulage:LOCAL_HAULAGE]->()
WITH count(localHaulage) AS relCount
CALL apoc.util.validate(relCount <> 4950, 'Count of TRUCK_LEG relationships is not 4950', [])
RETURN relCount;

// Vessel Nodes
MATCH (vessel:Vessel)
WITH count(vessel) AS nodeCount
CALL apoc.util.validate(nodeCount <> 8, 'Count of Vessel nodes is not 8', [])
RETURN nodeCount;

// Voyage Nodes
MATCH (voyage:Voyage)
WITH count(voyage) AS nodeCount
CALL apoc.util.validate(nodeCount <> 32, 'Count of Voyage nodes is not 32', [])
RETURN nodeCount;

// HAS_VESSEL Relationship
MATCH ()-[hasVessel:HAS_VESSEL]->()
WITH count(hasVessel) AS relCount
CALL apoc.util.validate(relCount <> 32, 'Count of HAS_VESSEL relationships is not 32', [])
RETURN relCount;

// IS_PART_OF Relationship
MATCH ()-[isPartOf:IS_PART_OF]->()
WITH count(isPartOf) AS relCount
CALL apoc.util.validate(relCount <> 210, 'Count of IS_PART_OF relationships is not 210', [])
RETURN relCount;