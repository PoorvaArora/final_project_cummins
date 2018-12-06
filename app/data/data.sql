DROP TABLE IF EXISTS client_engine_info;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS engine;

DROP TABLE IF EXISTS engine_time_series;


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

CREATE TABLE turbine (
  turbineId INT PRIMARY KEY NOT NULL,
  turbineName VARCHAR(31) NOT NULL,
  capacity NUMERIC NOT NULL,
  rampUpTime NUMERIC NOT NULL,
  maintenanceInterval NUMERIC NOT NULL
);

CREATE TABLE site (
  siteId INT PRIMARY KEY NOT NULL,
  clientId INT NOT NULL,
  siteName VARCHAR(31) NOT NULL,
  siteDescription VARCHAR(200) NOT NULL,
  primaryContact VARCHAR(31) NOT NULL,
  capacity INT NOT NULL,
  commercialDate DATE NOT NULL,
  addrLine1 VARCHAR(200) NOT NULL,
  addrLine2 VARCHAR(200),
  addrCity VARCHAR(31) NOT NULL,
  addrState VARCHAR(9) NOT NULL,
  addrZip VARCHAR(31) NOT NULL,
  addrCountry VARCHAR(31) NOT NULL,
  FOREIGN KEY (clientId) REFERENCES client(clientId)
);

CREATE TABLE turbineDeployed (
  turbineDeployedId INT PRIMARY KEY NOT NULL,
  turbineId INT,
  siteId INT,
  serialNumber VARCHAR(31) NOT NULL,
  deployedDate DATE NOT NULL,
  totalFiredHours NUMERIC NOT NULL,
  totalStarts NUMERIC NOT NULL,
  lastPlannedOutageDate DATE NOT NULL,
  lastUnplannedOutageDate DATE NOT NULL,
  FOREIGN KEY (turbineId) REFERENCES turbine(turbineId),
  FOREIGN KEY (siteId) REFERENCES site(siteId)
);

CREATE TABLE sensorDeployed (
  sensorDeployedId INT PRIMARY KEY NOT NULL,
  sensorId INT NOT NULL,
  turbineDeployedId INT NOT NULL,
  serialNumber VARCHAR(31) NOT NULL,
  deployedDate DATE NOT NULL,
  FOREIGN KEY (sensorId) REFERENCES sensor(sensorId)

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
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  note VARCHAR(30) NOT NULL,
  clientId INT NOT NULL,
  FOREIGN KEY (clientId) REFERENCES client(clientId)
);

INSERT INTO note (id, note, clientId)
VALUES (1, 'I have a note', 1);


/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 01-01-2016, 43.47905751,
    16.7855285, 3.3798722, 9840.755145
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 02-01-2016, 43.64784794,
    18.02466914, 3.00478235, 9732.789007
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 03-01-2016, 43.26132627,
    15.94683863, 3.86371939, 9634.607699
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 04-01-2016, 44.4191181,
    15.15002459, 1.29084866, 9732.295096
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 05-01-2016, 43.33184597,
    17.50945384, 3.70700896, 9767.372978
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 06-01-2016, 43.3847232,
    15.92876391, 3.58950401, 9820.934698
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 07-01-2016, 43.4236251,
    17.12276767, 3.50305533, 9812.810264
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 08-01-2016, 44.40325466,
    17.56053354, 1.32610075, 9756.489406
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 09-01-2016, 43.48651811,
    18.43188177, 3.36329309, 9782.968044
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 10-01-2016, 43.80489085,
    16.19540223, 2.65579812, 9649.285791
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 11-01-2016, 43.60324238,
    17.53524776, 3.10390582, 9815.848096
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 12-01-2016, 44.19062361,
    17.64697415, 1.7986142, 9641.920721
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 13-01-2016, 43.68729875,
    16.06806781, 2.91711389, 9745.463005
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 14-01-2016, 43.70505021,
    18.35578093, 2.87766619, 9842.505911
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 15-01-2016, 44.31975736,
    17.23074115, 1.51165031, 9729.9852
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 16-01-2016, 43.56913746,
    15.51917928, 3.17969454, 9643.336351
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 17-01-2016, 43.46044741,
    15.50636316, 3.42122798, 9722.761176
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 18-01-2016, 44.20495203,
    16.85478969, 1.76677327, 9811.638592
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 19-01-2016, 43.85170864,
    18.3264682, 2.55175857, 9748.209609
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 20-01-2016, 43.30799123,
    18.82954791, 3.76001948, 9811.647199
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 21-01-2016, 43.22720084,
    16.91398653, 3.93955369, 9802.576293
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 22-01-2016, 44.03424508,
    15.15379215, 2.14612204, 9845.638831
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 23-01-2016, 44.9162895,
    17.61175958, 0.18602333, 9785.06071
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 24-01-2016, 44.39779037,
    18.2833693, 1.33824363, 9653.404875
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 25-01-2016, 43.89192384,
    16.95875909, 2.46239146, 9818.692558
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 26-01-2016, 44.65393961,
    15.91006895, 0.7690231, 9773.807275
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 27-01-2016, 43.95883291,
    17.44668724, 2.31370465, 9729.635603
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 28-01-2016, 43.3086845,
    16.76187177, 3.75847889, 9788.131146
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 29-01-2016, 43.77866495,
    18.89034003, 2.7140779, 9805.749409
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 30-01-2016, 43.70178274,
    16.34985037, 2.88492725, 9679.170063
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 31-01-2016, 44.98481905,
    15.80107374, 0.03373544, 9713.751268
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 01-02-2016, 43.86346475,
    17.32056607, 2.52563389, 9700.460626
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 02-02-2016, 43.96102257,
    16.66835576, 2.30883873, 9791.010182
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 03-02-2016, 44.3081807,
    18.98722836, 1.53737623, 9735.324108
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 04-02-2016, 44.87724033,
    16.40609882, 0.27279926, 9690.026039
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 05-02-2016, 44.70218629,
    17.03425985, 0.27279926, 9690.026039
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 06-02-2016, 44.5979567,
    15.08670753, 0.89342956, 9693.425402
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 07-02-2016, 43.75485477,
    18.8038516, 2.76698939, 9783.734829
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 08-02-2016, 44.16070811,
    16.318534, 1.86509308, 9794.85642
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 09-02-2016, 44.42380708,
    18.13453628, 1.28042872, 9786.223219
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 10-02-2016, 44.82243515,
    17.71772769, 0.39458855, 9649.521586
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 11-02-2016, 44.80226017,
    15.27049141, 0.43942185, 9676.162852
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 12-02-2016, 44.34740208,
    16.52052355, 1.4502176, 9768.052763
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 13-02-2016, 44.72111326,
    16.97305449, 0.61974831, 9810.658683
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 14-02-2016, 44.8223545,
    15.21590139, 0.39476778, 9809.570351
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 15-02-2016, 43.25419121,
    18.83365968, 3.87957509, 9673.165655
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 16-02-2016, 44.77241165,
    16.06051387, 0.50575188, 9632.581018
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 17-02-2016, 43.26859267,
    16.40460169, 3.84757185, 9659.897954
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 18-02-2016, 44.79483014,
    18.67630943, 0.45593303, 9852.192569
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 19-02-2016, 44.83907862,
    17.74303361, 0.35760306, 9840.004036
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 20-02-2016, 43.32165306,
    18.02140207, 3.72965987, 9776.676857
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 21-02-2016, 43.83241425,
    17.82836374, 2.59463501, 9732.508314
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 22-02-2016, 44.46530215,
    15.54224106, 1.18821745, 9825.110133
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 23-02-2016, 43.79771872,
    15.60104632, 2.67173617, 9812.447201
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 24-02-2016, 43.32448293,
    18.07731786, 3.72337127, 9845.089461
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 25-02-2016, 43.55578092,
    16.93169734, 3.20937573, 9720.319797
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 26-02-2016, 44.50473299,
    16.36377245, 1.10059335, 9688.915182
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 27-02-2016, 44.27124313,
    18.86968603, 1.61945971, 9749.024081
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 28-02-2016, 43.75856666,
    16.24617594, 2.75874075, 9857.574375
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 29-02-2016, 44.55123588,
    16.21901857, 0.99725359, 9838.662922
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 01-03-2016, 44.47991831,
    15.86002541, 1.15573708, 9717.058233
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 02-03-2016, 43.71502775,
    15.16323635, 2.8554939, 9788.168997
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 03-03-2016, 44.46649638,
    15.1881763, 1.18556361, 9636.769423
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 04-03-2016, 43.96855089,
    15.57331957, 2.29210913, 9824.359887
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 05-03-2016, 44.20583505,
    15.36972638, 1.76481101, 9731.214047
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 06-03-2016, 43.96872174,
    18.03169369, 2.29172947, 9631.405999
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 07-03-2016, 43.80547761,
    17.89903653, 2.65449419, 9808.52323
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 08-03-2016, 44.72274482,
    16.93250032, 0.61612263, 9836.741788
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 09-03-2016, 44.68297625,
    15.97721752, 0.70449722, 9797.627042
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 10-03-2016, 43.90667047,
    16.73677286, 2.42962117, 9858.063462
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 11-03-2016, 44.46648594,
    15.55557307, 1.18558681, 9726.039204
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 12-03-2016, 44.07685992,
    17.38853702, 2.05142239, 9685.364364
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 13-03-2016, 44.1858857,
    18.10999806, 1.80914288, 9778.731556
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 14-03-2016, 43.5692844,
    15.90467881, 3.17936801, 9718.164334
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 15-03-2016, 44.54125162,
    17.35784132, 1.01944085, 9815.313094
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 16-03-2016, 44.62026973,
    16.67395045, 0.84384505, 9859.607001
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 17-03-2016, 44.06826672,
    18.96998422, 2.07051841, 9718.633742
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 18-03-2016, 43.39767803,
    18.52175864, 3.5607155, 9657.014714
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 19-03-2016, 43.23959078,
    18.23155707, 3.91202048, 9844.130066
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 20-03-2016, 44.76889332,
    15.68976705, 0.51357041, 9680.356539
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 21-03-2016, 43.43110002,
    15.73844076, 3.48644439, 9767.302844
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 22-03-2016, 43.61285619,
    16.80140824, 3.08254181, 9698.950907
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 23-03-2016, 43.483373,
    17.25734985, 3.37028223, 9772.165943
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 24-03-2016, 44.6340541,
    15.29468825, 0.81321311, 9821.87392
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 25-03-2016, 44.54398405,
    16.16196791, 1.01336878, 9745.455913
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 26-03-2016, 43.24290077,
    17.78456233, 3.90466496, 9728.025899
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 27-03-2016, 43.91501027,
    15.75679125, 2.41108829, 9809.384061
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 28-03-2016, 44.60855401,
    18.47732738, 0.86987997, 9717.813269
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 29-03-2016, 44.29209447,
    17.64118423, 1.5731234, 9800.932955
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 30-03-2016, 44.19110352,
    16.18525838, 1.79754773, 9635.098408
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 31-03-2016, 44.75435169,
    16.46104506, 0.54588513, 9845.750968
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 01-04-2016, 44.72507182,
    18.25004362, 0.61095151, 9778.3157
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 02-04-2016, 43.79624303,
    17.13955787, 2.6750155, 9634.54088
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 03-04-2016, 44.6206049,
    15.64258802, 0.84310022, 9689.891636
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 04-04-2016, 43.87801572,
    18.61967714, 2.49329841, 9791.758858
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 05-04-2016, 43.40433248,
    17.6624792, 3.54592783, 9667.000193
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 06-04-2016, 44.4335068,
    15.41518812, 1.25887377, 9812.796893
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 07-04-2016, 44.50547176,
    16.46216545, 1.09895164, 9660.075044
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 08-04-2016, 43.80669717,
    17.70986174, 2.65178407, 9713.063469
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 09-04-2016, 43.95982939,
    15.10509146, 2.31149025, 9695.490985
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 10-04-2016, 43.68361902,
    18.99887063, 2.92529107, 9839.792709
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 11-04-2016, 43.78616888,
    15.8248063, 2.69740249, 9651.9304
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 12-04-2016, 44.19093248,
    15.96115611, 1.79792782, 9846.581055
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 13-04-2016, 43.30719934,
    16.39189453, 3.76177925, 9698.978937
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 14-04-2016, 43.89902307,
    18.65574852, 2.44661541, 9695.21031
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 15-04-2016, 43.68194526,
    17.95182657, 2.92901054, 9740.252748
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 16-04-2016, 44.94818911,
    16.02898828, 0.11513532, 9758.040796
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 17-04-2016, 44.18689734,
    15.85965831, 1.80689481, 9730.01507
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 18-04-2016, 43.9861609,
    18.99167955, 2.25297578, 9750.534124
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 19-04-2016, 44.6981891,
    17.98878703, 0.6706909, 9714.15743
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 20-04-2016, 43.82629619,
    16.54886665, 2.6082307, 9790.04101
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 21-04-2016, 44.53995827,
    18.34920353, 1.02231495, 9721.221815
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 22-04-2016, 43.58532714,
    18.42110908, 3.14371746, 9849.59419
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 23-04-2016, 43.54875761,
    17.68694329, 3.22498308, 9839.612776
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 24-04-2016, 44.68078543,
    17.23945397, 0.70936572, 9723.325972
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 25-04-2016, 43.66183163,
    18.61188732, 2.9737075, 9794.975879
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 26-04-2016, 43.27018812,
    16.83660044, 3.84402641, 9794.312549
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 27-04-2016, 43.67200208,
    17.90472718, 2.9511065, 9693.407943
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 28-04-2016, 43.80764538,
    17.23380184, 2.64967694, 9720.768394
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 29-04-2016, 43.83962654,
    18.79344734, 2.57860769, 9653.016694
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 30-04-2016, 44.01130042,
    18.83777851, 2.19711018, 9719.41455
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 01-05-2016, 44.39900129,
    15.98434544, 1.33555269, 9810.794257
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 02-05-2016, 44.38432902,
    18.05593859, 1.36815774, 9646.227234
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 03-05-2016, 43.2609777,
    18.50085855, 3.86449399, 9700.05086
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 04-05-2016, 43.6031395,
    17.10756178, 3.10413445, 9822.376346
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 05-05-2016, 44.85545131,
    17.52228079, 0.32121932, 9659.075747
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 06-05-2016, 44.22804001,
    15.10153657, 1.71546664, 9695.892831
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 07-05-2016, 43.94687441,
    16.53381262, 2.34027908, 9773.167454
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 08-05-2016, 44.0185131,
    15.69597041, 2.18108201, 9845.973986
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 09-05-2016, 44.65245112,
    17.09931874, 0.77233085, 9732.738318
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 10-05-2016, 44.6573689,
    18.52171921, 0.76140244, 9667.58411
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 11-05-2016, 44.86711948,
    15.48293363, 0.29529004, 9743.653527
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 12-05-2016, 43.21143752,
    15.33556726, 3.9745833, 9806.743582
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 13-05-2016, 44.87704204,
    17.21626506, 0.27323991, 9642.288632
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 14-05-2016, 44.81740611,
    18.79970936, 0.40576421, 9645.112028
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 15-05-2016, 43.23883665,
    17.58755907, 3.91369633, 9695.570919
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 16-05-2016, 43.86356745,
    15.6308408, 2.52540566, 9724.113039
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 17-05-2016, 43.72745894,
    18.51013776, 2.82786902, 9730.316712
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 18-05-2016, 44.97212112,
    15.0743492, 0.06195307, 9677.7078
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 19-05-2016, 44.86087568,
    15.74898971, 0.30916516, 9691.802623
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 20-05-2016, 44.95920756,
    15.25846617, 0.09064986, 9632.440461
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 21-05-2016, 44.5697306,
    16.58537051, 0.95615423, 9653.574631
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 22-05-2016, 43.27421281,
    16.47400766, 3.83508265, 9804.474879
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 23-05-2016, 44.30110164,
    18.66716572, 1.55310747, 9661.122741
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 24-05-2016, 44.19367447,
    15.0108282, 1.79183451, 9710.026011
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 25-05-2016, 44.73289246,
    17.42187315, 0.59357232, 9649.33445
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 26-05-2016, 44.83800821,
    16.94427764, 0.35998175, 9827.711316
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 27-05-2016, 43.26112957,
    17.28671998, 3.86415651, 9734.324225
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 28-05-2016, 43.55820102,
    15.02034506, 3.20399773, 9665.852336
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 29-05-2016, 44.77449601,
    17.70538383, 0.50111997, 9775.017842
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 30-05-2016, 43.8201944,
    16.38778667, 2.62179022, 9742.319386
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 31-05-2016, 43.27399159,
    17.54770132, 3.83557424, 9727.155464
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002401, 01-06-2016, 43.98482047,
    15.60730486, 2.25595451, 9646.74981
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 01-01-2016, 43.31997818,
    16.5815121, 3.73338182, 9722.057029
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 02-01-2016, 44.95119426,
    16.21710663, 0.1084572, 9675.799264
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 03-01-2016, 43.45283875,
    15.45869788, 3.43813612, 9727.400509
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 04-01-2016, 44.28025269,
    15.86306401, 1.59943846, 9702.817553
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 05-01-2016, 43.35888078,
    16.80220947, 3.64693161, 9665.134267
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 06-01-2016, 43.48492812,
    17.17883128, 3.36682639, 9717.931071
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 07-01-2016, 43.5517623,
    16.86130985, 3.218306, 9644.922675
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 08-01-2016, 43.99366479,
    18.86751342, 2.23630046, 9678.868159
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 09-01-2016, 44.31507395,
    17.80234833, 1.52205788, 9700.867685
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 10-01-2016, 43.81967266,
    18.26367979, 2.62294965, 9638.289509
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 11-01-2016, 43.51415934,
    15.5189342, 3.30186813, 9645.274651
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 12-01-2016, 44.02438192,
    16.60312981, 2.16804017, 9666.634753
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 13-01-2016, 43.66381653,
    15.05842386, 2.9692966, 9706.19813
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 14-01-2016, 43.96699152,
    18.26065883, 2.29557441, 9725.874099
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 15-01-2016, 44.35236856,
    17.68350397, 1.43918097, 9659.024103
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 16-01-2016, 44.75318186,
    15.13355184, 0.54848476, 9655.190484
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 17-01-2016, 43.72178987,
    18.14719326, 2.84046695, 9721.670358
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 18-01-2016, 44.29998808,
    16.16253224, 1.55558204, 9661.632337
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 19-01-2016, 44.87377149,
    17.87016395, 0.2805078, 9720.8088
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 20-01-2016, 43.42644745,
    18.90802087, 3.49678344, 9669.093875
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 21-01-2016, 43.30346115,
    17.90943766, 3.77008634, 9703.972944
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 22-01-2016, 43.39420948,
    16.48069822, 3.56842338, 9728.118997
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 23-01-2016, 43.65997792,
    16.02551526, 2.97782685, 9725.848485
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 24-01-2016, 44.25070142,
    17.60163039, 1.66510796, 9651.282943
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 25-01-2016, 44.79013915,
    17.92014291, 0.46635744, 9694.131661
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 26-01-2016, 43.78234328,
    16.32147729, 2.70590383, 9664.725492
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 27-01-2016, 44.20900005,
    18.8595651, 1.75777767, 9649.086631
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 28-01-2016, 43.29087941,
    18.35255772, 3.79804575, 9710.204533
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 29-01-2016, 44.38920123,
    17.26371065, 1.35733061, 9692.730789
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 30-01-2016, 43.93543878,
    18.69872521, 2.36569161, 9707.743959
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 31-01-2016, 44.60778048,
    17.13390272, 0.87159893, 9702.772479
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 01-02-2016, 43.88392283,
    17.61004938, 2.4801715, 9634.025571
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 02-02-2016, 44.83608725,
    17.56576724, 0.36425055, 9644.147995
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 03-02-2016, 44.90318982,
    15.46485487, 0.21513374, 9671.155305
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 04-02-2016, 43.51578921,
    15.835259, 3.29824619, 9683.864577
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 05-02-2016, 44.89904659,
    15.1831744, 0.22434092, 9650.021736
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 06-02-2016, 44.57546478,
    18.92586266, 0.9434116, 9723.480123
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 07-02-2016, 43.38059289,
    16.94918275, 3.59868247, 9712.838885
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 08-02-2016, 44.22871481,
    17.71130403, 1.71396709, 9696.090854
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 09-02-2016, 44.29678027,
    17.81695955, 1.56271051, 9710.373526
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 10-02-2016, 44.80236234,
    15.5518616, 0.43919481, 9682.000655
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 11-02-2016, 44.06942072,
    16.42726669, 2.06795395, 9673.828134
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 12-02-2016, 44.62083712,
    18.23510513, 0.84258417, 9634.969192
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 13-02-2016, 43.27504722,
    17.15183758, 3.8332284, 9678.230506
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 14-02-2016, 43.8790425,
    15.4558108, 2.49101667, 9692.989577
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 15-02-2016, 43.99761153,
    15.59088168, 2.22752994, 9662.197431
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 16-02-2016, 44.88355367,
    16.79638347, 0.25876963, 9713.837152
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 17-02-2016, 43.93647303,
    18.21716298, 2.36339327, 9690.053744
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 18-02-2016, 44.90922476,
    18.78525547, 0.20172275, 9639.641661
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 19-02-2016, 43.53092264,
    16.97640321, 3.26461636, 9710.721878
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 20-02-2016, 44.47522932,
    18.48146565, 1.16615707, 9638.06907
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 21-02-2016, 43.57361646,
    18.73742078, 3.16974119, 9685.150506
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 22-02-2016, 44.16879203,
    18.39253037, 1.84712883, 9710.63166
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 23-02-2016, 44.61619352,
    15.50873756, 0.85290329, 9681.697167
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 24-02-2016, 43.871267,
    17.57285616, 2.50829555, 9711.542612
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 25-02-2016, 44.89721358,
    17.23530235, 0.22841427, 9728.951731
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 26-02-2016, 43.68008139,
    16.28625447, 2.93315246, 9661.746381
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 27-02-2016, 43.39807623,
    15.08126718, 3.5598306, 9687.278917
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 28-02-2016, 44.23642583,
    16.53940598, 1.69683149, 9721.745506
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 29-02-2016, 43.37955724,
    17.54038036, 3.60098391, 9721.540563
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 01-03-2016, 43.77133035,
    18.38862857, 2.73037701, 9710.849307
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 02-03-2016, 44.53994837,
    17.36646698, 1.02233695, 9746.254647
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 03-03-2016, 43.31496539,
    17.2257552, 3.74452135, 9748.873791
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 04-03-2016, 43.82046115,
    15.42233984, 2.62119745, 9746.74563
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 05-03-2016, 44.57810189,
    15.79241877, 0.93755136, 9757.396693
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 06-03-2016, 44.05622611,
    17.39662037, 2.09727532, 9756.920239
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 07-03-2016, 43.59044813,
    18.65713831, 3.13233749, 9750.007301
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 08-03-2016, 44.45282372,
    18.64607431, 1.21594729, 9758.630376
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 09-03-2016, 43.46305824,
    16.01150489, 3.41542614, 9764.681778
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 10-03-2016, 43.89995164,
    18.12754917, 2.44455191, 9756.000331
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 11-03-2016, 43.48019646,
    16.89559728, 3.37734119, 9765.760734
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 12-03-2016, 43.63761861,
    16.98743592, 3.02751419, 9774.289382
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 13-03-2016, 43.64206459,
    17.04726725, 3.01763425, 9763.347808
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 14-03-2016, 43.82682418,
    16.41431359, 2.60705738, 9763.490066
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 15-03-2016, 43.97204873,
    15.57332301, 2.28433616, 9783.23566
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 16-03-2016, 44.31133318,
    17.17899846, 1.53037072, 9761.75199
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 17-03-2016, 44.06958935,
    17.79596553, 2.06757923, 9802.764146
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 18-03-2016, 44.46033135,
    15.11890701, 1.19926367, 9791.658791
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 19-03-2016, 44.69897037,
    18.14831914, 0.66895473, 9783.919581
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 20-03-2016, 44.23902884,
    17.65209723, 1.69104703, 9802.123932
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 21-03-2016, 43.99037263,
    18.72328809, 2.24361638, 9806.769805
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 22-03-2016, 44.27997184,
    17.04040739, 1.60006257, 9794.926671
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 23-03-2016, 43.31710142,
    15.11353238, 3.73977463, 9783.113932
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 24-03-2016, 43.9577051,
    17.27392801, 2.3162109, 9811.424194
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 25-03-2016, 44.75561423,
    17.19781362, 0.54307949, 9784.590026
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 26-03-2016, 43.24799816,
    15.20164409, 3.89333742, 9739.348447
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 27-03-2016, 43.76942691,
    18.84768889, 2.73460686, 9781.866529
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 28-03-2016, 44.86907363,
    15.09146017, 0.2909475, 9845.809953
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 29-03-2016, 43.78214265,
    15.06498308, 2.70634967, 9859.329707
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 30-03-2016, 44.7729067,
    16.06922785, 0.50465178, 9815.063412
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 31-03-2016, 44.16139175,
    18.89574409, 1.86357389, 9818.990083
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 01-04-2016, 44.0107979,
    18.19844896, 2.19822689, 9824.057858
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 02-04-2016, 43.21906189,
    16.28992011, 3.95764025, 9784.447902
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 03-04-2016, 43.79308304,
    15.3695443, 2.6820377, 9821.063592
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 04-04-2016, 43.87668926,
    16.6996775, 2.49624608, 9813.170806
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 05-04-2016, 44.62058339,
    17.19487662, 0.84314802, 9879.906386
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 06-04-2016, 44.93231946,
    18.34178032, 0.15040121, 9796.361102
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 07-04-2016, 43.57393388,
    16.93809032, 3.16903583, 9853.950982
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 08-04-2016, 43.24229345,
    17.16487527, 3.90601455, 9789.749132
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 09-04-2016, 44.72620517,
    15.01326134, 0.60843295, 9778.925542
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 10-04-2016, 44.31288665,
    16.72000788, 1.52691855, 9856.186235
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 11-04-2016, 43.47539542,
    15.47929223, 3.38801018, 9879.477041
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 12-04-2016, 43.86556407,
    16.74140343, 2.52096874, 9816.173632
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 13-04-2016, 43.72975347,
    17.81509768, 2.82277006, 9829.06171
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 14-04-2016, 43.93431923,
    16.4465733, 2.3681795, 9795.612905
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 15-04-2016, 44.48980231,
    16.99439169, 1.13377264, 9868.381355
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 16-04-2016, 43.51570352,
    16.96692544, 3.29843663, 9817.953205
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 17-04-2016, 44.84791575,
    17.03605654, 0.33796499, 9927.976861
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 18-04-2016, 43.51515082,
    17.36617333, 3.29966484, 9806.083623
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 19-04-2016, 43.23125776,
    16.89117537, 3.93053831, 9870.080101
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 20-04-2016, 44.86218507,
    18.6292757, 0.30625539, 9865.360796
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 21-04-2016, 44.63550587,
    16.83819882, 0.80998696, 9845.52777
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 22-04-2016, 43.26018549,
    17.17059146, 3.86625447, 9846.389096
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 23-04-2016, 43.51073718,
    16.35758324, 3.30947293, 9876.809179
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 24-04-2016, 44.71218261,
    16.26003337, 0.63959419, 9920.988966
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 25-04-2016, 44.74830608,
    16.96434441, 0.55931982, 9864.101425
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 26-04-2016, 44.09886405,
    16.73480468, 2.00252434, 9910.979317
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 27-04-2016, 44.69505648,
    18.47140818, 0.67765226, 9862.907506
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 28-04-2016, 44.52308365,
    17.22822444, 1.05981412, 9895.562025
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 29-04-2016, 43.4214239,
    15.87577501, 3.50794688, 10099.58364
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 30-04-2016, 44.19278173,
    18.08063164, 1.79381838, 9858.813166
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 01-05-2016, 43.47478781,
    17.38691419, 3.38936043, 9860.974297
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 02-05-2016, 44.72667394,
    18.62797228, 0.60739125, 9907.447791
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 03-05-2016, 43.58280615,
    15.50013814, 3.14931967, 9992.118319
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 04-05-2016, 44.89667298,
    16.28690681, 0.22961559, 9640.043515
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 05-05-2016, 44.36396238,
    16.16078223, 1.41341694, 9843.653073
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 06-05-2016, 44.0281332,
    17.57123055, 2.159704, 9861.42018
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 07-05-2016, 43.6506035,
    17.22271276, 2.99865888, 9768.462283
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 08-05-2016, 44.3319325,
    18.94522693, 1.48459445, 9853.475097
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 09-05-2016, 43.9936455,
    17.33780582, 2.23634333, 9786.844354
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 10-05-2016, 44.15173933,
    18.761298, 1.88502372, 9865.704088
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 11-05-2016, 43.22330562,
    17.55768264, 3.94820973, 9778.903281
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 12-05-2016, 43.9748323,
    18.83733751, 2.27815044, 9991.333657
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 13-05-2016, 43.58211676,
    15.39974112, 3.15085165, 9834.217202
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 14-05-2016, 44.87817154,
    15.16404086, 0.27072991, 9978.229813
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 15-05-2016, 43.84655262,
    18.02347106, 2.56321641, 9879.875698
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 16-05-2016, 44.43250502,
    17.89239755, 1.26109996, 9796.329278
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 17-05-2016, 44.66040435,
    17.0253641, 0.75465699, 9865.893408
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 18-05-2016, 44.48942248,
    18.19708219, 1.13461671, 9790.96419
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 19-05-2016, 43.66462108,
    17.16850895, 2.96750872, 10010.22754
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 20-05-2016, 43.32354418,
    17.39596267, 3.72545738, 9924.283587
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 21-05-2016, 43.78070794,
    16.4358655, 2.70953791, 9783.617228
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 22-05-2016, 44.03826461,
    15.12416719, 2.13718976, 9981.817429
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 23-05-2016, 44.69000306,
    16.40811469, 0.6888821, 9857.981261
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 24-05-2016, 43.28703735,
    17.76998182, 3.80658366, 9786.80208
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 25-05-2016, 44.53220535,
    15.74594598, 1.03954366, 10041.07919
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 26-05-2016, 44.77457662,
    17.20790145, 0.50094084, 9778.61764
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 27-05-2016, 44.12089269,
    18.53866227, 1.95357181, 9819.061546
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 28-05-2016, 43.70018703,
    16.00641901, 2.88847327, 9795.367286
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 29-05-2016, 44.72479287,
    17.41528117, 0.61157141, 9796.514963
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 30-05-2016, 44.52338633,
    17.67036567, 1.05914149, 10001.87984
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 31-05-2016, 44.37253301,
    15.28659748, 1.3943711, 9965.690302
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1002402, 01-06-2016, 44.54081163,
    17.91820752, 1.0204186, 9975.859881
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 01-01-2016, 44.56823501,
    16.72684685, 0.95947775, 9654.188471
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 02-01-2016, 44.89280395,
    17.1802644, 0.23821344, 9641.705487
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 03-01-2016, 44.47806854,
    16.76629487, 1.15984768, 9684.365185
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 04-01-2016, 44.26218199,
    17.78976209, 1.63959558, 9640.720536
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 05-01-2016, 44.57218528,
    18.38060919, 0.95069938, 9757.823181
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 06-01-2016, 44.20058559,
    16.79332696, 1.77647646, 9796.259665
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 07-01-2016, 44.29639181,
    15.44093941, 1.56357375, 9790.229073
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 08-01-2016, 43.77167157,
    16.93078383, 2.72961874, 9784.016206
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 09-01-2016, 43.96393533,
    16.21092911, 2.30236594, 9702.079022
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 10-01-2016, 43.75869109,
    17.49667495, 2.75846425, 9710.342852
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 11-01-2016, 44.87238093,
    15.4391236, 0.28359793, 9652.024135
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 12-01-2016, 44.87358402,
    15.07336568, 0.28092441, 9702.086073
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 13-01-2016, 43.37702829,
    15.45053591, 3.60660381, 9787.845912
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 14-01-2016, 44.69363146,
    15.80406978, 0.68081898, 9748.765638
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 15-01-2016, 44.57615902,
    15.98673732, 0.94186884, 9656.092879
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 16-01-2016, 43.44856386,
    17.39445048, 3.44763587, 9824.748128
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 17-01-2016, 44.48228297,
    15.07811225, 1.1504823, 9756.171101
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 18-01-2016, 44.79695407,
    16.7681886, 0.45121318, 9695.298923
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 19-01-2016, 44.44566734,
    16.72464716, 1.23185035, 9757.102002
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 20-01-2016, 44.75388281,
    16.63875103, 0.54692708, 9761.144689
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 21-01-2016, 43.69527851,
    16.91479105, 2.8993811, 9793.364507
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 22-01-2016, 43.6465145,
    17.01607493, 3.00774555, 9796.263479
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 23-01-2016, 44.62513708,
    17.11591826, 0.83302872, 9737.225115
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 24-01-2016, 44.31172048,
    16.40169975, 1.52951005, 9647.032004
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 25-01-2016, 44.40615594,
    15.57827376, 1.31965347, 9784.177311
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 26-01-2016, 44.67221599,
    16.68552426, 0.72840891, 9693.076847
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 27-01-2016, 43.47773904,
    16.20414237, 3.38280214, 9735.856545
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 28-01-2016, 43.83587367,
    18.30878288, 2.58694739, 9648.361954
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 29-01-2016, 44.91673567,
    16.2128723, 0.18503184, 9765.683959
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 30-01-2016, 43.90663022,
    18.80782867, 2.42971063, 9738.158193
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 31-01-2016, 44.4763318,
    18.34427799, 1.16370711, 9712.040954
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 01-02-2016, 44.75477243,
    15.33519012, 0.54495015, 9764.391527
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 02-02-2016, 43.87688887,
    18.68896638, 2.49580252, 9722.103406
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 03-02-2016, 44.36262461,
    15.21885678, 1.41638975, 9844.569614
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 04-02-2016, 43.65515168,
    18.0096408, 2.98855183, 9834.173125
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 05-02-2016, 44.94012162,
    16.46696181, 0.13306307, 9831.729768
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 06-02-2016, 43.87843962,
    15.09201441, 2.49235641, 9797.823943
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 07-02-2016, 43.26460886,
    15.45626036, 3.85642475, 9819.519984
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 08-02-2016, 44.13650393,
    17.20835845, 1.91888016, 9679.4664
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 09-02-2016, 44.04855792,
    15.99205649, 2.11431574, 9798.103359
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 10-02-2016, 44.21798834,
    15.62386559, 1.73780368, 9675.178877
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 11-02-2016, 44.13957048,
    15.45147941, 1.91206559, 9646.033216
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 12-02-2016, 43.53336368,
    16.15500856, 3.25919182, 9844.69298
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 13-02-2016, 43.68392535,
    18.52349287, 2.92461034, 9765.407179
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 14-02-2016, 43.95866148,
    16.98740139, 2.31408559, 9769.96428
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 15-02-2016, 44.2441067,
    16.74315514, 1.67976288, 9761.868572
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 16-02-2016, 43.95907618,
    17.30817713, 2.31316404, 9672.29191
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 17-02-2016, 43.58060469,
    15.29256143, 3.15421179, 9695.515229
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 18-02-2016, 44.00298395,
    16.36786809, 2.21559122, 9816.467772
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 19-02-2016, 44.27533089,
    15.77600059, 1.6103758, 9723.443856
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 20-02-2016, 43.42832359,
    16.81521238, 3.49261424, 9715.536049
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 21-02-2016, 43.5427704,
    16.43602009, 3.23828799, 9755.669771
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 22-02-2016, 43.8424958,
    16.48676986, 2.57223156, 9750.557213
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 23-02-2016, 43.5287259,
    15.35890424, 3.269498, 9711.108019
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 24-02-2016, 44.27070858,
    17.19746443, 1.62064759, 9728.432546
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 25-02-2016, 44.96567211,
    18.37134461, 0.07628421, 9696.198577
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 26-02-2016, 43.93885187,
    16.06215923, 2.35810695, 9674.997432
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 27-02-2016, 44.90289546,
    15.00371284, 0.21578786, 9844.667676
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 28-02-2016, 44.32134904,
    17.85108525, 1.50811325, 9642.60427
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 29-02-2016, 43.97403481,
    18.60276109, 2.27992264, 9799.166012
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 01-03-2016, 44.6636209,
    18.54435285, 0.74750912, 9714.130735
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 02-03-2016, 44.31704333,
    18.04193254, 1.5176815, 9675.533003
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 03-03-2016, 44.06749097,
    18.67687972, 2.0722423, 9668.740634
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 04-03-2016, 44.93701184,
    15.63958803, 0.13997368, 9713.010017
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 05-03-2016, 43.47602729,
    16.77892999, 3.38660602, 9788.544721
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 06-03-2016, 43.62646846,
    15.91479319, 3.05229231, 9691.97453
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 07-03-2016, 44.29096299,
    15.54520881, 1.5756378, 9727.104647
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 08-03-2016, 44.39534711,
    16.79613316, 1.34367308, 9651.998297
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 09-03-2016, 44.06786072,
    16.60822396, 2.07142063, 9755.797247
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 10-03-2016, 44.13830401,
    18.46894338, 1.91487997, 9720.938584
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 11-03-2016, 44.78361222,
    16.90758633, 0.48086173, 9741.950309
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 12-03-2016, 44.30616987,
    18.81750883, 1.54184473, 9775.970456
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 13-03-2016, 44.62098024,
    17.14555011, 0.84226614, 9762.85219
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 14-03-2016, 43.75826414,
    17.53205279, 2.75941303, 9830.657669
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 15-03-2016, 43.28630696,
    16.15484612, 3.80820676, 9700.057444
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 16-03-2016, 44.16140435,
    17.88269012, 1.86354589, 9766.820098
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 17-03-2016, 44.53132628,
    18.90696309, 1.04149716, 9641.931097
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 18-03-2016, 43.57064842,
    18.62003688, 3.17633685, 9663.370499
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 19-03-2016, 44.80015226,
    18.81956946, 0.44410608, 9643.033821
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 20-03-2016, 43.2939393,
    18.32554033, 3.791246, 9676.264692
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 21-03-2016, 44.72513132,
    17.89967573, 0.61081929, 9797.276038
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 22-03-2016, 44.42218357,
    17.59157946, 1.28403652, 9722.836012
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 23-03-2016, 44.2116413,
    15.84063955, 1.75190822, 9635.549718
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 24-03-2016, 43.55396789,
    15.36077108, 3.21340469, 9649.636076
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 25-03-2016, 44.72704384,
    18.42528223, 0.60656924, 9835.073517
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 26-03-2016, 43.209355, 18.49745562,
    3.97921112, 9807.76008
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 27-03-2016, 44.20325018,
    15.25341475, 1.77055516, 9833.206953
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 28-03-2016, 43.82493985,
    17.73110679, 2.61124478, 9721.355533
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 29-03-2016, 43.87956643,
    16.49746108, 2.48985237, 9771.326837
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 30-03-2016, 43.85928278,
    16.04553231, 2.53492716, 9832.70949
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 31-03-2016, 44.96264865,
    15.53409315, 0.083003, 9771.569185
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 01-04-2016, 44.9577869,
    17.09399525, 0.0938069, 9657.249091
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 02-04-2016, 43.92616327,
    18.39961216, 2.38630384, 9854.864481
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 03-04-2016, 44.37386701,
    16.1592846, 1.39140665, 9734.713537
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 04-04-2016, 43.96134168,
    17.63536271, 2.3081296, 9853.213091
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 05-04-2016, 43.76164221,
    15.66679471, 2.75190619, 9712.745232
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 06-04-2016, 43.57592845,
    17.35822634, 3.16460345, 9858.673966
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 07-04-2016, 44.62961804,
    16.25324767, 0.82307103, 9827.170547
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 08-04-2016, 43.72545322,
    18.71883681, 2.83232617, 9827.717682
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 09-04-2016, 43.8832419,
    15.45107615, 2.48168466, 9686.344213
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 10-04-2016, 43.28892007,
    15.30501877, 3.80239984, 9701.83635
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 11-04-2016, 43.68909066,
    16.092653, 2.91313187, 9675.518137
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 12-04-2016, 43.45660019,
    18.81115852, 3.42977735, 9639.636995
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 13-04-2016, 43.44121132,
    16.07871992, 3.46397485, 9823.467899
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 14-04-2016, 43.86005859,
    17.21848948, 2.53320313, 9815.659415
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 15-04-2016, 43.27194754,
    18.15861909, 3.84011658, 9821.5562
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 16-04-2016, 44.95502274,
    15.81104673, 0.09994947, 9836.695759
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 17-04-2016, 44.42116769,
    17.61463776, 1.28629403, 9761.462601
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 18-04-2016, 43.24237555,
    16.04536581, 3.90583212, 9809.426307
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 19-04-2016, 44.40053897,
    15.76572881, 1.33213562, 9667.714815
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 20-04-2016, 44.71245599,
    18.95516977, 0.63898669, 9738.99301
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 21-04-2016, 43.91262199,
    16.11415975, 2.41639557, 9799.944025
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 22-04-2016, 43.77439845,
    17.17680215, 2.723559, 9779.419465
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 23-04-2016, 44.70055353,
    16.69392505, 0.66543659, 9823.258966
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 24-04-2016, 44.11295727,
    18.90927297, 1.97120606, 9783.37286
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 25-04-2016, 44.3916724,
    15.88741191, 1.35183911, 9773.925691
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 26-04-2016, 44.17391295,
    18.93050467, 1.83574899, 9666.609147
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 27-04-2016, 44.03754565,
    17.04548137, 2.13878744, 9646.867387
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 28-04-2016, 43.39933023,
    16.25163184, 3.55704393, 9733.399492
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 29-04-2016, 43.37232302,
    17.08191284, 3.61705996, 9660.932369
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 30-04-2016, 44.55483685,
    15.57758934, 0.98925145, 9673.20102
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 01-05-2016, 43.98398159,
    16.97154381, 2.25781868, 9776.835079
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 02-05-2016, 44.93626611,
    18.60030164, 0.14163087, 9782.330624
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 03-05-2016, 43.36907981,
    15.8046327, 3.62426709, 9694.723159
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 04-05-2016, 43.42078439,
    18.83195551, 3.50936802, 9655.033299
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 05-05-2016, 43.25518816,
    15.20067085, 3.87735965, 9670.38905
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 06-05-2016, 44.93900068,
    16.99672356, 0.13555404, 9828.757775
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 07-05-2016, 43.49774704,
    17.06660781, 3.33833991, 9642.67308
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 08-05-2016, 44.63146019,
    17.49756346, 0.81897735, 9727.80332
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 09-05-2016, 44.66957218,
    18.75153143, 0.73428404, 9653.042338
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 10-05-2016, 44.1651215,
    16.85007046, 1.85528555, 9853.582034
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 11-05-2016, 44.57845679,
    17.83275829, 0.93676268, 9835.248425
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 12-05-2016, 43.78059392,
    18.76678083, 2.70979128, 9665.585884
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 13-05-2016, 43.24908382,
    17.85475715, 3.89092484, 9680.960768
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 14-05-2016, 43.82897235,
    16.14813339, 2.60228367, 9818.115897
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 15-05-2016, 44.98691157,
    18.95407964, 0.02908539, 9737.908488
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 16-05-2016, 44.13467614,
    16.12666926, 1.92294192, 9643.78571
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 17-05-2016, 44.55380525,
    16.91500286, 0.99154389, 9841.09991
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 18-05-2016, 44.18745093,
    18.01791464, 1.80566461, 9849.607212
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 19-05-2016, 44.8776774,
    15.06855671, 0.271828, 9664.425906
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 20-05-2016, 43.93092061,
    15.0177995, 2.37573198, 9849.529393
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 21-05-2016, 43.83099532,
    16.89954598, 2.59778818, 9725.0101
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 22-05-2016, 43.88373675,
    16.81665384, 2.48058501, 9719.011243
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 23-05-2016, 44.28662675,
    17.90455471, 1.58527388, 9818.555161
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 24-05-2016, 43.96101759,
    15.50212216, 2.3088498, 9835.845414
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 25-05-2016, 44.06329952,
    15.05095422, 2.08155662, 9703.260201
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 26-05-2016, 43.59194328,
    17.55847684, 3.12901493, 9761.340454
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 27-05-2016, 43.5464376,
    17.72584266, 3.23013867, 9738.159389
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 28-05-2016, 44.52661222,
    15.69198908, 1.05197285, 9748.092204
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 29-05-2016, 44.45371975,
    17.53028183, 1.21395611, 9836.038402
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 30-05-2016, 43.3812788,
    15.39412312, 3.59715823, 9754.693276
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 31-05-2016, 43.2989131,
    15.76059375, 3.78019311, 9704.738111
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    986202, 01-06-2016, 43.92226048,
    17.2292828, 2.39497671, 9725.54014
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 01-01-2016, 44.89673936,
    17.34581335, 0.22946809, 9679.623573
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 02-01-2016, 44.95821926,
    16.54632496, 0.09284609, 9789.425616
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 03-01-2016, 43.83959969,
    15.79057985, 2.57866736, 9665.973778
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 04-01-2016, 44.55185347,
    17.23987297, 0.99588118, 9688.469297
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 05-01-2016, 44.74048329,
    18.93222539, 0.5767038, 9643.361585
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 06-01-2016, 43.90565071,
    17.30327475, 2.43188731, 9819.400479
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 07-01-2016, 43.6546642,
    17.86893311, 2.98963512, 9836.581954
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 08-01-2016, 43.73611942,
    17.49856039, 2.80862352, 9666.263432
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 09-01-2016, 44.59391549,
    16.00457235, 0.90241002, 9705.404121
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 10-01-2016, 44.03202921,
    18.31917592, 2.15104619, 9692.659168
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 11-01-2016, 44.58780408,
    18.48312984, 0.91599093, 9829.150564
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 12-01-2016, 44.71487057,
    16.19288268, 0.63362095, 9829.923961
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 13-01-2016, 44.04859444,
    17.33426039, 2.11423458, 9847.022894
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 14-01-2016, 44.19339374,
    17.00401093, 1.79245836, 9780.671443
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 15-01-2016, 44.96472938,
    17.69731875, 0.07837916, 9672.111242
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 16-01-2016, 44.98323808,
    15.10767611, 0.03724872, 9730.88969
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 17-01-2016, 44.2048104,
    18.17549396, 1.76708799, 9684.764164
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 18-01-2016, 43.61834509,
    18.11238935, 3.07034425, 9820.515736
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 19-01-2016, 43.75492768,
    15.62597656, 2.76682737, 9698.820576
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 20-01-2016, 44.232666,
    17.37307491, 1.70518667, 9694.102908
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 21-01-2016, 43.79676776,
    18.63510415, 2.67384943, 9653.845115
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 22-01-2016, 44.21807329,
    17.9369894, 1.73761492, 9731.463399
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 23-01-2016, 43.6354245,
    15.85139444, 3.03238999, 9835.948095
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 24-01-2016, 44.73983656,
    17.4088659, 0.57814097, 9802.160557
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 25-01-2016, 44.70173245,
    18.43047942, 0.66281677, 9828.169405
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 26-01-2016, 43.57382872,
    18.59195734, 3.16926951, 9767.363704
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 27-01-2016, 44.8579288,
    15.46423723, 0.31571378, 9694.257736
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 28-01-2016, 44.69562495,
    18.08310402, 0.67638901, 9773.143039
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 29-01-2016, 43.46088344,
    16.95408982, 3.42025903, 9676.530698
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 30-01-2016, 44.62050371,
    15.00913072, 0.84332509, 9759.659928
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 31-01-2016, 43.82154284,
    15.7922035, 2.6187937, 9744.461976
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 01-02-2016, 43.83303318,
    15.09926921, 2.59325959, 9654.112992
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 02-02-2016, 44.2993714,
    16.03547296, 1.55695244, 9690.377746
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 03-02-2016, 44.8549832,
    17.54185701, 0.32225956, 9845.612303
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 04-02-2016, 43.49895945,
    18.18497735, 3.33564567, 9690.950129
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 05-02-2016, 44.98375298,
    15.31788418, 0.03610448, 9829.601898
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 06-02-2016, 44.15039114,
    18.80233528, 1.8880197, 9791.427715
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 07-02-2016, 44.94301623,
    18.45050891, 0.1266306, 9701.319847
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 08-02-2016, 44.18475271,
    16.12137339, 1.81166064, 9813.98048
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 09-02-2016, 44.80518984,
    17.51590033, 0.43291147, 9738.355309
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 10-02-2016, 43.75116753,
    17.9064346, 2.77518326, 9634.227543
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 11-02-2016, 44.35963498,
    18.38270159, 1.42303338, 9753.481617
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 12-02-2016, 44.1160041,
    16.82205116, 1.96443534, 9820.00995
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 13-02-2016, 43.31531133,
    16.1222647, 3.74375261, 9804.063377
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 14-02-2016, 44.24680764,
    16.65441481, 1.67376079, 9710.665037
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 15-02-2016, 43.91310843,
    15.79948342, 2.41531459, 9700.621946
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 16-02-2016, 44.09308408,
    15.06307294, 2.01536872, 9796.909195
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 17-02-2016, 43.92476306,
    16.68362658, 2.38941543, 9774.570599
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 18-02-2016, 44.42853918,
    18.81974492, 1.26991294, 9694.630813
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 19-02-2016, 44.83786429,
    15.84786186, 0.36030157, 9848.821929
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 20-02-2016, 44.16933875,
    15.27431641, 1.84591389, 9678.303959
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 21-02-2016, 44.90345655,
    16.82234914, 0.214541, 9747.025361
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 22-02-2016, 43.90794333,
    17.32318329, 2.42679261, 9831.895322
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 23-02-2016, 43.80873309,
    16.41746054, 2.6472598, 9633.30589
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 24-02-2016, 44.62888125,
    18.17372117, 0.82470833, 9746.109786
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 25-02-2016, 44.65266579,
    15.74749247, 0.7718538, 9808.070794
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 26-02-2016, 44.85934224,
    18.07383168, 0.31257279, 9669.025883
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 27-02-2016, 44.70668091,
    17.01408176, 0.65182021, 9647.263428
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 28-02-2016, 44.76430188,
    18.89584447, 0.5237736, 9673.24312
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 29-02-2016, 44.2472627,
    15.31368869, 1.67274955, 9853.638442
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 01-03-2016, 43.97581837,
    17.00451835, 2.27595917, 9783.617899
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 02-03-2016, 43.65381211,
    15.25971371, 2.99152865, 9790.798917
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 03-03-2016, 44.37976832,
    18.95865573, 1.37829263, 9709.551638
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 04-03-2016, 43.67698981,
    16.03630499, 2.94002264, 9642.770618
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 05-03-2016, 44.08783678,
    15.71591658, 2.02702937, 9711.895981
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 06-03-2016, 44.92324742,
    17.47246624, 0.17056129, 9711.190025
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 07-03-2016, 43.49538152,
    16.7412021, 3.34359662, 9856.000981
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 08-03-2016, 44.16419944,
    18.94426881, 1.85733458, 9726.931729
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 09-03-2016, 44.71767725,
    16.14721917, 0.62738389, 9694.790024
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 10-03-2016, 44.56555234,
    16.54757717, 0.96543924, 9678.228941
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 11-03-2016, 43.78890606,
    18.27568703, 2.69131987, 9657.426335
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 12-03-2016, 43.93827366,
    15.8426389, 2.35939187, 9812.367816
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 13-03-2016, 43.62437372,
    15.91388872, 3.05694729, 9653.121543
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 14-03-2016, 43.71207716,
    18.302431, 2.86205075, 9651.947565
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 15-03-2016, 43.94484377,
    17.76211735, 2.34479163, 9705.089615
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 16-03-2016, 43.31701572,
    17.43470993, 3.73996506, 9750.760647
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 17-03-2016, 44.60644911,
    17.88698915, 0.87455754, 9723.140041
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 18-03-2016, 44.81316273,
    15.7288402, 0.41519394, 9694.254323
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 19-03-2016, 44.48909619,
    16.61599633, 1.13534179, 9747.36176
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 20-03-2016, 43.21622975,
    17.76014781, 3.96393388, 9746.499957
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 21-03-2016, 43.63205549,
    17.34063005, 3.03987668, 9850.652706
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 22-03-2016, 44.01555663,
    18.86776856, 2.18765194, 9680.045994
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 23-03-2016, 44.09105953,
    17.00548988, 2.01986771, 9694.617341
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 24-03-2016, 43.83058218,
    16.70614535, 2.59870627, 9819.5559
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 25-03-2016, 43.48105727,
    16.96766213, 3.37542829, 9780.525428
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 26-03-2016, 44.15477808,
    16.19766928, 1.87827093, 9688.585265
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 27-03-2016, 43.97637201,
    15.70952511, 2.27472886, 9660.429556
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 28-03-2016, 43.84945202,
    17.57183918, 2.55677328, 9684.486644
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 29-03-2016, 44.976841,
    17.20234565, 0.05146444, 9755.668236
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 30-03-2016, 44.25480479,
    17.25816698, 1.65598936, 9845.68034
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 31-03-2016, 43.89943641,
    18.33801312, 2.44569687, 9828.886912
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 01-04-2016, 44.59896638,
    17.21858148, 0.89118582, 9633.098533
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 02-04-2016, 44.33534188,
    15.14134827, 1.47701805, 9703.482025
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 03-04-2016, 44.82228619,
    17.59142379, 0.39491958, 9852.943408
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 04-04-2016, 44.83801277,
    18.16138298, 0.35997163, 9705.67443
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 05-04-2016, 44.7555268,
    15.53727135, 0.54327377, 9810.277095
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 06-04-2016, 44.36217183,
    17.95373588, 1.41739593, 9670.793145
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 07-04-2016, 44.39973191,
    17.13500577, 1.3339291, 9692.859255
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 08-04-2016, 44.88698682,
    15.56019622, 0.2511404, 9760.122923
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 09-04-2016, 44.87214779,
    18.73126378, 0.28411602, 9836.826949
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 10-04-2016, 43.2394451,
    18.69763721, 3.91234422, 9691.191542
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 11-04-2016, 44.90634066,
    15.0931912, 0.20813187, 9806.547657
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 12-04-2016, 44.22098945,
    15.11242655, 1.73113455, 9630.841354
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 13-04-2016, 44.64844148,
    17.24825504, 0.78124116, 9848.121707
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 14-04-2016, 44.35861855,
    17.37373092, 1.42529211, 9757.078022
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 15-04-2016, 44.19595072,
    16.63765228, 1.78677617, 9859.518009
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 16-04-2016, 44.89444434,
    17.68458211, 0.23456813, 9769.901531
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 17-04-2016, 43.9534894,
    16.53284043, 2.32557911, 9692.489487
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 18-04-2016, 43.88917754,
    18.70429175, 2.46849436, 9685.565947
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 19-04-2016, 43.5172199,
    16.32306172, 3.29506688, 9806.010268
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 20-04-2016, 43.45329311,
    17.61137103, 3.43712642, 9804.887701
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 21-04-2016, 43.54378414,
    16.75711875, 3.23603525, 9853.051414
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 22-04-2016, 43.41069849,
    18.53819169, 3.53178114, 9680.969439
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 23-04-2016, 43.82340428,
    17.5709395, 2.61465715, 9696.993377
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 24-04-2016, 44.20882325,
    15.24910303, 1.75817055, 9733.989102
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 25-04-2016, 44.89628166,
    18.86781712, 0.23048521, 9696.193719
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 26-04-2016, 43.47552537,
    15.22045885, 3.38772141, 9670.262096
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 27-04-2016, 43.43881993,
    18.31136128, 3.46928904, 9837.160444
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 28-04-2016, 43.55100594,
    15.10977182, 3.21998679, 9823.239898
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 29-04-2016, 43.82332814,
    16.46267281, 2.61482635, 9787.400527
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 30-04-2016, 44.83721358,
    17.51680294, 0.3617476, 9782.228698
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 01-05-2016, 44.95448936,
    18.05017389, 0.10113475, 9745.789412
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 02-05-2016, 44.41080231,
    16.40683637, 1.3093282, 9738.204904
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 03-05-2016, 43.83397535,
    16.75985656, 2.59116589, 9761.136233
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 04-05-2016, 44.63523633,
    17.31819903, 0.81058593, 9752.750347
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 05-05-2016, 44.98565778,
    16.71814043, 0.0318716, 9780.883338
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 06-05-2016, 43.41361855,
    17.82047417, 3.52529211, 9652.421833
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 07-05-2016, 44.97576273,
    18.90127201, 0.05386061, 9638.144254
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 08-05-2016, 44.11825536,
    15.0784201, 1.95943254, 9763.473098
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 09-05-2016, 43.53157722,
    17.74050363, 3.26316174, 9697.688308
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 10-05-2016, 44.08148675,
    18.94616178, 2.04114055, 9646.454269
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 11-05-2016, 44.58961645,
    18.90090382, 0.91196344, 9653.191152
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 12-05-2016, 43.34623042,
    15.34036427, 3.67504352, 9696.393254
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 13-05-2016, 44.97264138,
    17.61403255, 0.06079694, 9641.491585
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 14-05-2016, 43.404512,
    16.58501429, 3.5455289, 9792.42833
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 15-05-2016, 43.83804708,
    15.77660386, 2.5821176, 9696.816409
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 16-05-2016, 44.73544302,
    15.16372217, 0.5879044, 9690.392289
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 17-05-2016, 44.32631135,
    16.16825481, 1.49708588, 9828.603545
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 18-05-2016, 44.19127947,
    17.69711069, 1.79715674, 9688.064321
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 19-05-2016, 44.21647661,
    16.46317264, 1.74116309, 9723.232226
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 20-05-2016, 43.91104611,
    16.56385565, 2.41989754, 9726.271961
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 21-05-2016, 44.07745626,
    16.40844062, 2.05009719, 9849.596327
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 22-05-2016, 44.4928874,
    15.33480072, 1.12691689, 9694.738448
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 23-05-2016, 44.16585043,
    17.03193036, 1.85366571, 9749.618121
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 24-05-2016, 44.22749814,
    15.13801593, 1.71667079, 9682.304417
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 25-05-2016, 43.32649191,
    18.57227712, 3.71890687, 9702.043405
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 26-05-2016, 44.83025268,
    17.44811661, 0.37721627, 9750.414017
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 27-05-2016, 43.95131401,
    15.04449815, 2.33041332, 9702.736988
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 28-05-2016, 44.50148089,
    16.13147499, 1.10782024, 9742.682866
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 29-05-2016, 44.70231981,
    16.36423782, 0.66151153, 9816.080022
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 30-05-2016, 43.8175209,
    17.15278818, 2.62773133, 9668.365474
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 31-05-2016, 43.27440298,
    16.10112598, 3.83466004, 9799.268703
  );
/* INSERT QUERY */
INSERT INTO engine_time_series(
  sensorId, dataCollectedDate, thermalEfficiency,
  firedHours, unnitiatedShutdownRate,
  fuelConsumption
)
VALUES
  (
    1019203, 01-06-2016, 44.01458793,
    16.65443961, 2.18980459, 9772.672946
  );



  select cei.clientId, c.clientName, c.clientLocation, cei.engineId, e.engineName from client_engine_info cei inner join client c on cei.clientId = c.clientId inner join engine e on cei.engineId = e.engineId;
