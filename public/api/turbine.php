<?php

require '../../app/common.php';


// 1. Go to the database and get selected turbine
$turbineId = intval($_GET['turbineId'] ?? 0);

if ($turbineId < 1) {
  // 1. Go to the database and get all client
  $turbine = Turbine::fetchAll();

  // 2. Convert to JSON
  $json = json_encode($turbine, JSON_PRETTY_PRINT);

  // 3. Print
  header('Content-Type: application/json');
  echo $json;
}
else {
$turbineById = Turbine::fetchTurbineByTurbineId($turbineId);

// 2. Convert to JSON
$json = json_encode($turbineById, JSON_PRETTY_PRINT);

// 3. Print
header('Content-Type: application/json');
echo $json;
}
