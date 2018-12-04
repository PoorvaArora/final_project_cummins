<?php

class ClientProduct
{

  public $clientId;
  public $engineId;

  public function __construct($data) {
    $this->clientId = isset($data['clientId']) ? intval($data['clientId']) : null;
    $this->$engineId = $data['$engineId'];
  }

  public static function fetchAll() {
    // 1. Connect to the database
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);

    // 2. Prepare the query
    $sql = 'select cei.clientId, c.clientName, c.clientLocation, cei.engineId, e.engineName from client_engine_info cei inner join client c on cei.clientId = c.clientId inner join engine e on cei.engineId = e.engineId';
    $statement = $db->prepare($sql);

    // 3. Run the query
    $success = $statement->execute();

    // 4. Handle the results
    $arr = [];
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
      $theClientProduct =  new ClientProduct($row);
      array_push($arr, $theClientProduct);
    }

    return $arr;
  }

}
