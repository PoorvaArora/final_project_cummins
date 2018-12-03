<?php

class TurbineDeployed
{

  public $turbineDeployedId;
  public $turbineId;
  public $siteId;
  public $serialNumber;
  public $deployedDate;
  public $totalFiredHours;
  public $totalStarts;
  public $lastPlannedOutageDate;


  public function __construct($data) {
    $this->turbineDeployedId= isset($data['turbineDeployedId']) ? intval($data['turbineDeployedId']) : null;
    $this->turbineId = $data ['turbineId'];
    $this->siteId = $data['siteId'];
    $this->serialNumber = $data['serialNumber'];
    $this->deployedDate = $data['deployedDate'];
    $this->totalFiredHours = $data['totalFiredHours'];
    $this->totalStarts = $data['totalStarts'];
    $this->lastPlannedOutageDate = $data['lastPlannedOutageDate'];
    $this->lastUnplannedOutageDate = $data['lastUnplannedOutageDate'];
  }

  public static function fetchAll() {
    // 1. Connect to the database
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);

    // 2. Prepare the query
    $sql = 'SELECT * FROM turbineDeployed';
    $statement = $db->prepare($sql);

    // 3. Run the query
    $success = $statement->execute();

    // 4. Handle the results
    $arr = [];
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
      $theTurbineDeployed =  new TurbineDeployed($row);
      array_push($arr, $theTurbineDeployed);
    }

    return $arr;
  }

}
