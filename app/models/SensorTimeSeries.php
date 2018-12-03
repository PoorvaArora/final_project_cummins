<?php

class sensorTimeSeries
{
  public $sensorDeployedId;
  public $dataCollectedDate;
  public $output;
  public $heartRate;
  public $compressorEfficiency;
  public $availability;
  public $reliability;
  public $firedHours;
  public $trips;
  public $starts;

  public function __construct($data) {
    $this->sensorDeployedId = isset($data['sensorDeployedId']) ? intval($data['sensorDeployedId']) : null;
    $this->dataCollectedDate = $data['dataCollectedDate'];
    $this->output = $data['output'];
    $this->heatRate = $data['heatRate'];
    $this->compressorEfficiency = $data['compressorEfficiency'];
    $this->availability = $data['availability'];
    $this->compressorEfficiency = $data['compressorEfficiency'];
    $this->reliability = $data['reliability'];
    $this->firedHours = $data['firedHours'];
    $this->trips = $data['trips'];
    $this->starts= $data['starts'];

  }

  public static function fetchAll() {
    // 1. Connect to the database
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);

    // 2. Prepare the query
    $sql = 'SELECT * FROM sensorTimeSeries';
    $statement = $db->prepare($sql);

    // 3. Run the query
    $success = $statement->execute();

    // 4. Handle the results
    $arr = [];
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
      $thesensorTimeSeries =  new SensorTimeSeries($row);
      array_push($arr, $thesensorTimeSeries);
    }

    return $arr;
  }

  public static function fetchTimeSeriesByTurbineId(int $sensorDeployedId) {
    // 1. Connect to the database
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);

    // 2. Prepare the query
    $sql = 'SELECT * from sensorTimeSeries where sensorDeployedId = ?';
    //$sql = 'SELECT * FROM note WHERE clientId = ?';

    $statement = $db->prepare($sql);

    // 3. Run the query
    $success = $statement->execute(
        [$sensorDeployedId]
    );

    // 4. Handle the results
    $arr = [];
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
      // 4.a. For each row, make a new work object
      $sensorTimeSeriesItem =  new SensorTimeSeries($row);

      array_push($arr, $sensorTimeSeriesItem);
    }
    return $arr;
  }

}
