<?php

require '../../app/common.php';

// 1. Go to the database and get all client
$clientProduct = ClientProduct::fetchAll();

// 2. Convert to JSON u
$json = json_encode($clientProduct, JSON_PRETTY_PRINT);

// 3. Print
header('Content-Type: application/json');
echo $json;
