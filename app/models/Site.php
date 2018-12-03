<?php

class Site
{

  public $siteId;
  public $clientId;
  public $siteName;
  public $siteDescription;
  public $primaryContact;
  public $capacity;
  public $commercialDate;
  public $addrLine1;
  public $addrLine2;
  public $addrCity;
  public $addrState;
  public $addrZip;
  public $addrCountry;

  public function __construct($data) {
    $this->siteId = isset($data['siteId']) ? intval($data['siteId']) : null;
    $this->clientId= $data['clientId'];
    $this->siteName = $data['siteName'];
    $this->siteDescription = $data['siteDescription'];
    $this->primaryContact = $data['primaryContact'];
    $this->capacity = $data['capacity'];
    $this->commercialDate = $data['commercialDate'];
    $this->addrLine1 = $data['addrLine1'];
    $this->addrLine2 = $data['addrLine2'];
    $this->addrCity = $data['addrCity'];
    $this->addrState = $data['addrState'];
    $this->addrZip = $data['addrZip'];
    $this->addrCountry = $data['addrCountry'];
  }

  public static function fetchAll() {
    // 1. Connect to the database
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);

    // 2. Prepare the query
    $sql = 'SELECT * FROM site';
    $statement = $db->prepare($sql);

    // 3. Run the query
    $success = $statement->execute();

    // 4. Handle the results
    $arr = [];
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
      $theSite =  new Site($row);
      array_push($arr, $theSite);
    }

    return $arr;
  }

  public static function fetchSiteBySiteId(int $siteId) {
    // 1. Connect to the database
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);

    // 2. Prepare the query
    $sql = 'SELECT * FROM site WHERE siteId = ?';

    $statement = $db->prepare($sql);

    // 3. Run the query
    $success = $statement->execute(
        [$siteId]
    );

    // 4. Handle the results
    $arr = [];
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
      // 4.a. For each row, make a new work object
      $siteItem =  new Site($row);

      array_push($arr, $siteItem);
    }
    return $arr;
  }

}
