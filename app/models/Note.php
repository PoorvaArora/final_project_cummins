<?php

class Note
{
  public $engineId;
  public $clientId;
  public $sensorId;
  public $note;

  public function __construct($data) {
    $this->clientId = isset($data['clientId']) ? intval($data['clientId']) : null;
    $this->engineId =  intval($data['engineId']);
    $this->sensorId =  intval($data['sensorId']);
    $this->note = $data['note'];
  }

  public function create() {
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);
    $sql = 'INSERT INTO note (clientId, engineId, sensorId, note)
            VALUES (?,?,?)';

    $statement = $db->prepare($sql);

    $success = $statement->execute([
      $this->id,
      $this->clientId,
      $this->note

    ]);

    if (!$success) {
      // TODO: Better error handling
      die('SQL error');
    }
    $this->id = $db->lastInsertId();
  }

  public static function fetchAll() {
    // 1. Connect to the database
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);

    // 2. Prepare the query
    $sql = 'SELECT * FROM note';
    $statement = $db->prepare($sql);

    // 3. Run the query
    $success = $statement->execute();

    // 4. Handle the results
    $arr = [];
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
      $theNote =  new Note($row);
      array_push($arr, $theNote);
    }

    return $arr;
  }

  public static function fetchNotesByClientId(int $clientId) {
    // 1. Connect to the database
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);

    // 2. Prepare the query
    $sql = 'SELECT * FROM note WHERE clientId = ?';

    $statement = $db->prepare($sql);

    // 3. Run the query
    $success = $statement->execute(
        [$clientId]
    );

    // 4. Handle the results
    $arr = [];
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
      // 4.a. For each row, make a new work object
      $noteItem =  new Note($row);

      array_push($arr, $noteItem);
    }
    return $arr;
  }

}
