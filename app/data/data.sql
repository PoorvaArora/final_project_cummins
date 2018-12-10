DROP TABLE IF EXISTS client_engine_info;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS engine;
DROP TABLE IF EXISTS engine_time_series;
DROP TABLE IF EXISTS note;


CREATE TABLE engine (
  engineId INT PRIMARY KEY NOT NULL,
  engineName VARCHAR(31) NOT NULL,
  engineDescription VARCHAR(31) NOT NULL
);
insert into engine (engineId, engineName, engineDescription) values (1001,"Engine01","Engine 1001");
insert into engine (engineId, engineName, engineDescription) values (1002,"Engine02","Engine 1002");
insert into engine (engineId, engineName, engineDescription) values (1003,"Engine03","Engine 1003");


CREATE TABLE client (
  clientId INT PRIMARY KEY NOT NULL,
  clientName VARCHAR(31) NOT NULL,
  clientLocation VARCHAR(31) NOT NULL
  -- productId INT NOT NULL,
  -- FOREIGN KEY (productId) REFERENCES product(productId)
);

insert into client (clientId, clientName, clientLocation) values (10024,"Dow Chemical Co","China");
insert into client (clientId, clientName, clientLocation) values (9862,"Honeywell","India");
insert into client (clientId, clientName, clientLocation) values (10192,"Nucor Corp","Germany");

CREATE TABLE client_engine_info (
    clientId INT NOT NULL,
    engineId INT NOT NULL,
    sensorId INT NOT NULL,
    FOREIGN KEY (clientId) REFERENCES client(clientId),
    FOREIGN KEY (engineId) REFERENCES engine(engineId),
    PRIMARY KEY (clientId, engineId)
  );

insert into client_engine_info (clientId, engineId, sensorId) values (10024, 1001, 1002401);
insert into client_engine_info (clientId, engineId, sensorId) values (10024, 1002, 1002402);
insert into client_engine_info (clientId, engineId, sensorId) values (9862, 1002, 986202);
insert into client_engine_info (clientId, engineId, sensorId) values (10192, 1003, 1019203);

CREATE TABLE engine_time_series
(
  sensorId INT NOT NULL,
  dataCollectedDate DATE NOT NULL,
  thermalEfficiency NUMERIC NOT NULL,
  firedHours NUMERIC NOT NULL,
  unnitiatedShutdownRate NUMERIC NOT NULL,
  fuelConsumption NUMERIC NOT NULL
);

DROP VIEW IF EXISTS cummins;
CREATE VIEW  AS cummins
(SELECT c.clientId, c.clientName, c.clientLocation, e.engineId, e.engineName, e.engineDescription
FROM client c LEFT JOIN engineId e ON e.engineId = c.clientId
WHERE c.clientId IS NOT NULL);

CREATE TABLE sensor (
  sensorId INT PRIMARY KEY NOT NULL,
  sensorName VARCHAR(31) NOT NULL,
  sensorDescription VARCHAR(200) NOT NULL,
  manufacturer VARCHAR(31) NOT NULL,
  totalLifeExpentancyHours NUMERIC NOT NULL
);


CREATE TABLE sensorTimeSeries
(
  sensorDeployedId INT NOT NULL,
  dataCollectedDate DATE NOT NULL,
  output NUMERIC NOT NULL,
  heatRate NUMERIC NOT NULL,
  compressorEfficiency NUMERIC NOT NULL,
  availability NUMERIC NOT NULL,
  reliability NUMERIC NOT NULL,
  firedHours NUMERIC NOT NULL,
  trips INT NOT NULL,
  starts INT NOT NULL,
  FOREIGN KEY (sensorDeployedId) REFERENCES sensorDeployed(sensorDeployedId)
);

CREATE TABLE note (
  note VARCHAR(30) NOT NULL,
  clientId INT NOT NULL,
  name VARCHAR(30) NOT NULL,
  dateId DATE NOT NULL,
  engineId INT NOT NULL
);

INSERT INTO note (note, clientId, name, dateId,engineId)
VALUES ("Multiple Shutdown in past few months",10024,'Poorva','2018-12-08',1001);


INSERT INTO note (id, note, clientId)
VALUES (1, 'I have a note', 1);


/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS engine_time_series(
  sensorId INT(11),
  dataCollectedDate VARCHAR(100),
  thermalEfficiency DECIMAL(10, 2),
  firedHours DECIMAL(10, 2),
  unnitiatedShutdownRate DECIMAL(10, 2),
  fuelConsumption DECIMAL(10, 2)
);

select cei.clientId, c.clientName, c.clientLocation, cei.engineId, e.engineName from client_engine_info cei inner join client c on cei.clientId = c.clientId inner join engine e on cei.engineId = e.engineId;
