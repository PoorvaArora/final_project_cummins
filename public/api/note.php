<?php

require '../../app/common.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
  require 'notePost.php';
  exit;
}

$clientId = intval($_GET['clientId'] ?? 0);

if($clientId < 1){
  // 1. Go to the database and get all client
  $note = Note::fetchAll();

  // 2. Convert to JSON u
  $json = json_encode($note, JSON_PRETTY_PRINT);

  // 3. Print
  header('Content-Type: application/json');
  echo $json;
}
else {
$notesByClientId = Note::fetchNotesByClientId($clientId);

// 2. Convert to JSON
$json = json_encode($notesByClientId, JSON_PRETTY_PRINT);

// 3. Print
header('Content-Type: application/json');
echo $json;
}
