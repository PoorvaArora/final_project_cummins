var kpiApp = new Vue({
  el: '#agsKPI',
  data: {
    sensorTime:[],
    turbines:[],
    sensorsDeployed:[],
    turbineId: null,
    sensorDeployedId: null,
    newTurbineHealthForm: ''
  },
  computed: {
  },
  methods: {
    fetchSensorTimeSeries() {
      var urlArray = window.location.href.split("?");
      var numIds = urlArray[1].match(/\d+/g).map(Number);
      var sensorId = numIds[0];
      fetch('api/sensorTimeSeries.php?sensorId='+sensorId)
      .then( response => response.json() )
      // ^ This is the same as .then( function(response) {return response.json()} )
      .then( json => {
        kpiApp.sensorTime = json;
        kpiApp.formatSensorTime();
        kpiApp.buildThermalEfficiencyChart();
        kpiApp.buildUnnitiatedShutdownRateChart();
        kpiApp.buildFiredHoursChart();
        kpiApp.buildFuelConsumptionChart();
    //  console.log(agsApp.sensors);
    })
      .catch( err => {
        console.log('SENSOR FETCH ERROR:');
        console.log(err);
      })
    },
    formatSensorTime(){
      this.sensorTime.forEach(
        (entry, index, arr) => {
          entry.dateCollected = Date.parse(entry.dataCollectedDate);
          entry.thermalEfficiency = Number(entry.thermalEfficiency);
          entry.firedHours = Number(entry.firedHours);
          entry.unnitiatedShutdownRate = Number(entry.unnitiatedShutdownRate);
          entry.fuelConsumption = Number(entry.fuelConsumption);
        }
      )
    },
    buildThermalEfficiencyChart() {
      Highcharts.chart('thermalEfficiencyChart', {
            chart: {
                zoomType: 'x'
            },
            title: {
                text: 'Thermal Efficiency'
            },
            xAxis: {
                type: 'datetime'
            },
            yAxis: {
                title: {
                    text: 'Thermal Efficiency'
                }
            },
            legend: {
                enabled: false
            },
            plotOptions: {
                area: {
                    fillColor: {
                        linearGradient: {
                            x1: 0,
                            y1: 0,
                            x2: 0,
                            y2: 1
                        },
                        stops: [
                            [0, "#2d9d47"],
                            [1, "#006440"]
                        ]
                    },
                    marker: {
                        radius: 2
                    },
                    lineWidth: 1,
                    states: {
                        hover: {
                            lineWidth: 1
                        }
                    },
                    threshold: null
                }
            },
            series: [{
                type: 'area',
                name: 'Trips',
                data: kpiApp.sensorTime.map( entry=>
                  [entry.dateCollected, entry.thermalEfficiency]
                )
            }]
        });
    },
    buildUnnitiatedShutdownRateChart() {
      Highcharts.chart('unnitiatedShutdownRateChart', {
            chart: {
                zoomType: 'x'
            },
            title: {
                text: 'Unnitiated Shutdown Rate'
            },
            xAxis: {
                type: 'datetime'
            },
            yAxis: {
                title: {
                    text: 'Unnitiated Shutdown Rate'
                }
            },
            legend: {
                enabled: false
            },
            plotOptions: {
                area: {
                    fillColor: {
                        linearGradient: {
                            x1: 0,
                            y1: 0,
                            x2: 0,
                            y2: 1
                        },
                        stops: [
                            [0, '#6c5b7b'],
                            [1, '#c06c84']
                        ]
                    },
                    marker: {
                        radius: 2
                    },
                    lineWidth: 1,
                    states: {
                        hover: {
                            lineWidth: 1
                        }
                    },
                    threshold: null
                }
            },
            series: [{
                type: 'area',
                name: 'Unnitiated Shutdown Rate',
                data: kpiApp.sensorTime.map( entry=>
                  [entry.dateCollected, entry.unnitiatedShutdownRate]
                )
            }]
        });
    },
    buildFiredHoursChart() {
      Highcharts.chart('firedHoursChart', {
            chart: {
                zoomType: 'x'
            },
            title: {
                text: 'Fired Hours'
            },
            xAxis: {
                type: 'datetime'
            },
            yAxis: {
                title: {
                    text: 'Fired Hours'
                }
            },
            legend: {
                enabled: false
            },
            plotOptions: {
                area: {
                    fillColor: {
                        linearGradient: {
                            x1: 0,
                            y1: 0,
                            x2: 0,
                            y2: 1
                        },
                        stops: [
                            [0, '#c06c84'],
                            [1, '#f67280']
                        ]
                    },
                    marker: {
                        radius: 2
                    },
                    lineWidth: 1,
                    states: {
                        hover: {
                            lineWidth: 1
                        }
                    },
                    threshold: null
                }
            },
            series: [{
                type: 'area',
                name: 'Fired Hours',
                data: kpiApp.sensorTime.map( entry=>
                  [entry.dateCollected, entry.firedHours]
                )
            }]
        });
    },
    buildFuelConsumptionChart() {
      Highcharts.chart('fuelConsumptionChart', {
            chart: {
                zoomType: 'x'
            },
            title: {
                text: 'Fuel Consumption'
            },
            xAxis: {
                type: 'datetime'
            },
            yAxis: {
                title: {
                    text: 'Fuel Consumption'
                }
            },
            legend: {
                enabled: false
            },
            plotOptions: {
                area: {
                    fillColor: {
                        linearGradient: {
                            x1: 0,
                            y1: 0,
                            x2: 0,
                            y2: 1
                        },
                        stops: [
                            [0,'#f8b195'],
                            [1, '#f67280']
                        ]
                    },
                    marker: {
                        radius: 2
                    },
                    lineWidth: 1,
                    states: {
                        hover: {
                            lineWidth: 1
                        }
                    },
                    threshold: null
                }
            },
            series: [{
                type: 'area',
                name: 'Fuel Consumption',
                data: kpiApp.sensorTime.map( entry=>
                  [entry.dateCollected, entry.fuelConsumption]
                )
            }]
        });
    },
  },
  created () {
    this.fetchSensorTimeSeries();
  }
})
