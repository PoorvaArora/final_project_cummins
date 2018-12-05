<?php

class sensorTimeSeries
{
  public $sensorId;
  public $dataCollectedDate;
  public $thermalEfficiency;
  public $firedHours;
  public $unnitiatedShutdownRate;
  public $fuelConsumption;

  public function __construct($data) {
    $this->sensorDeployedId = isset($data['sensorId']) ? intval($data['sensorId']) : null;
    $this->dataCollectedDate = $data['dataCollectedDate'];
    $this->thermalEfficiency = $data['thermalEfficiency'];
    $this->firedHours = $data['firedHours'];
    $this->unnitiatedShutdownRate = $data['unnitiatedShutdownRate'];
    $this->fuelConsumption = $data['fuelConsumption'];
  }

  public static function fetchTimeSeriesBySensorId(int $sensorId) {
    // 1. Connect to the database
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);

    // 2. Prepare the query
    $sql = 'SELECT * from engine_time_series where sensorId = ?';
    //$sql = 'SELECT * FROM note WHERE clientId = ?';

    $statement = $db->prepare($sql);

    // 3. Run the query
    $success = $statement->execute(
        [$sensorId]
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
