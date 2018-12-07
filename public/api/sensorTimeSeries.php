<?php

require '../../app/common.php';

$sensorId = intval($_GET['sensorId'] ?? 0);

$sensorTimeSeriesBySensorId = SensorTimeSeries::fetchTimeSeriesBySensorId($sensorId);

// 2. Convert to JSON
$json = json_encode($sensorTimeSeriesBySensorId, JSON_PRETTY_PRINT);

// 3. Print
header('Content-Type: application/json');
echo $json;
