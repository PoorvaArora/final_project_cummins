<?php

class Client
{

  public $clientId;
  public $clientName;
  public $clientDescription;
  public $productId;

  public function __construct($data) {
    $this->clientId = isset($data['clientId']) ? intval($data['clientId']) : null;
    $this->clientName = $data['clientName'];
    $this->clienLocation = $data['clienLocation'];
    $this->productId = $data['productId'];
  }

  public static function fetchAll() {
    // 1. Connect to the database
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);

    // 2. Prepare the query
    $sql = 'SELECT * FROM client';
    $statement = $db->prepare($sql);

    // 3. Run the query
    $success = $statement->execute();

    // 4. Handle the results
    $arr = [];
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
      $theClient =  new Client($row);
      array_push($arr, $theClient);
    }

    return $arr;
  }

}
