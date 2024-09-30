// Define the start datetime and set the number of days
// Start time in this example: 2024-01-01T10:00:00 
// Number of days in this example: 100
WITH localdatetime({year: 2024, month: 1, day: 1, hour: 10, minute: 0, second: 0}) AS startDate, 100 AS days

// Match all existing Terminal nodes
MATCH (t:Terminal)
WITH t, startDate, days

// For each timestamp, create a TimeExpandedTerminal node with an incremented timestamp
UNWIND range(0, days - 1) AS i
WITH t, startDate, startDate + duration({days: i}) AS timestamp

// Create or match the TimeExpandedTerminal node for each day and connect it to the Terminal
MERGE (tet:TimeExpandedTerminal {terminalCode: t.terminalCode, timestamp: timestamp, lat: t.lat, lon: t.lon})
MERGE (t)-[:IS_TIME_EXPANDED_TO]->(tet)

WITH t, collect(tet) AS timeExpandedNodes

// Create :HAS_TIME_SUCESSOR relationships between consecutive TimeExpandedTerminal nodes
// Can later be used to employ wait at terminal relationships
UNWIND range(0, size(timeExpandedNodes) - 2) AS j
WITH timeExpandedNodes[j] AS current, timeExpandedNodes[j+1] AS next
MERGE (current)-[:HAS_DIRECT_SUCCESSOR]->(next);

// Create indexes
CREATE INDEX terminal_code_index FOR (t:Terminal) ON (t.terminalCode);
CREATE INDEX time_expanded_terminal_index FOR (tet:TimeExpandedTerminal) ON (tet.timestamp);
