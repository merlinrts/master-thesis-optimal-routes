LOAD CSV WITH HEADERS FROM 'file:///vessels.csv' AS row

CREATE
    (vessel:Vessel {
        vesselId: toInteger(row.vesselId),
        name: row.name,
        flag: row.flag
    });