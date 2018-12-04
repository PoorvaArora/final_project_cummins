DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS sensor;
DROP TABLE IF EXISTS turbine;
DROP TABLE IF EXISTS site;
DROP TABLE IF EXISTS turbineDeployed;
DROP TABLE IF EXISTS sensorDeployed;
DROP TABLE IF EXISTS sensorTimeSeries;
DROP TABLE IF EXISTS note;

CREATE TABLE product (
  productId INT PRIMARY KEY NOT NULL,
  productName VARCHAR(31) NOT NULL,
  productDescription VARCHAR(31) NOT NULL
);
insert into product (productId, productName, productDescription) values (1001,"Engine01","Engine 1001");
insert into product (productId, productName, productDescription) values (1002,"Engine02","Engine 1002");
insert into product (productId, productName, productDescription) values (1003,"Engine03","Engine 1003");


CREATE TABLE client (
  clientId INT PRIMARY KEY NOT NULL,
  clientName VARCHAR(31) NOT NULL,
  clientLocation VARCHAR(31) NOT NULL,
  productId INT NOT NULL,
  FOREIGN KEY (productId) REFERENCES product(productId)
);
insert into client (clientId, clientName, clientLocation,productId) values (10024,"Dow Chemical Co","China",1001);
insert into client (clientId, clientName, clientLocation,productId) values (10024,"Dow Chemical Co","China",1002);
insert into client (clientId, clientName, clientLocation,productId) values (9862,"Honeywell","India",1002);
insert into client (clientId, clientName, clientLocation,productId) values (10192,"Nucor Corp","Germany",1003);




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
