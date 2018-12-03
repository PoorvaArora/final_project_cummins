<?php

require '../../app/common.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
  require 'clientPost.php';
  exit;
}

// 1. Go to the database and get all client
$client = Client::fetchAll();

// 2. Convert to JSON u
$json = json_encode($client, JSON_PRETTY_PRINT);

// 3. Print
header('Content-Type: application/json');
echo $json;
