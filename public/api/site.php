<?php

require '../../app/common.php';


// 1. Go to the database and get selected turbine
$siteId = intval($_GET['siteId'] ?? 0);

if ($siteId < 1) {
  throw new Exception('Invalid Site ID');
}

$siteById = Site::fetchSiteBySiteId($siteId);

// 2. Convert to JSON
$json = json_encode($siteById, JSON_PRETTY_PRINT);

// 3. Print
header('Content-Type: application/json');
echo $json;
