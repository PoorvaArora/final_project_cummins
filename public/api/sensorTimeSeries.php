<?php

require '../../app/common.php';

$sensorDeployedId = intval($_GET['sensorDeployedId'] ?? 0);

if($sensorDeployedId < 1){
  // 1. Go to the database and get all client
  $sensorTimeSeries = SensorTimeSeries::fetchAll();

  // 2. Convert to JSON u
  $json = json_encode($sensorTimeSeries, JSON_PRETTY_PRINT);

  // 3. Print
  header('Content-Type: application/json');
  echo $json;
}
else {
$sensorTimeSeriesBySensorDeployedId = SensorTimeSeries::fetchTimeSeriesByTurbineId($sensorDeployedId);

// 2. Convert to JSON
$json = json_encode($sensorTimeSeriesBySensorDeployedId, JSON_PRETTY_PRINT);

// 3. Print
header('Content-Type: application/json');
echo $json;
}


//
// // 1. Go to the database and get all client
// $sensorTimeSeries = SensorTimeSeries::fetchAll();
//
// // 2. Convert to JSON
// $json = json_encode($sensorTimeSeries, JSON_PRETTY_PRINT);
//
// // 3. Print
// header('Content-Type: application/json');
// echo $json;
