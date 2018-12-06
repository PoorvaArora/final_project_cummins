<?php

require '../../app/common.php';

$sensorId = intval($_GET['sensorId'] ?? 0);

$sensorTimeSeriesBySensorId = SensorTimeSeries::fetchTimeSeriesBySensorId($sensorId);

// 2. Convert to JSON
$json = json_encode($sensorTimeSeriesBySensorId, JSON_PRETTY_PRINT);

// 3. Print
header('Content-Type: application/json');
echo $json;



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
