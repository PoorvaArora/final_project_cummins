<?php

require '../../app/common.php';

$turbineId = intval($_GET['turbineId'] ?? 0);

if($turbineId < 1){
// 1. Go to the database and get all client
$sensorDeployed = SensorDeployed::fetchAll();

// 2. Convert to JSON
$json = json_encode($sensorDeployed, JSON_PRETTY_PRINT);

// 3. Print
header('Content-Type: application/json');
echo $json;
}
else {
$sensorDeployedByTurbineId = SensorDeployed::fetchSensorDeployedByTurbineId($turbineId);

// 2. Convert to JSON
$json = json_encode($sensorDeployedByTurbineId, JSON_PRETTY_PRINT);

// 3. Print
header('Content-Type: application/json');
echo $json;
}
