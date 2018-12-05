var agsApp = new Vue({
  el: '#agsClient',
  data: {
    clients:[],
    successAlert: false,
    failureAlert: false,
    showBusyCursor: false
  },
  computed: {
  },
  methods: {
    fetchClients () {
      fetch('api/clientProduct.php')
      .then( response => response.json() )
      // ^ This is the same as .then( function(response) {return response.json()} )
      .then( json => {agsApp.clients = json})
      .catch( err => {
        console.log('TASK FETCH ERROR:');
        console.log(err);
      })
    },
    checkStatus(clientId,engineId){
      if(clientId == 9862 && engineId == 1002){
          setTimeout(function(){
          this.failureAlert = true;
          this.successAlert = false;
          this.showBusyCursor = false;
        }, 3000);
      }
      else {
        setTimeout(function(){
        this.successAlert = true;
        this.failureAlert = false;
        this.showBusyCursor = false;
      }, 3000);
      }
    },
    checkDetails(sensorId){
      window.location.replace("kpi.html?"+sensorId);
      // fetch('api/sensorTimeSeries.php?sensorId='+sensorId)
      // .then( response => response.json() )
      // // ^ This is the same as .then( function(response) {return response.json()} )
      // .then( json => {kpiApp.sensorsDeployed = json})
      // .catch( err => {
      //   console.log('TASK FETCH ERROR:');
      //   console.log(err);
      // })
    }
  },
  created () {
    this.fetchClients();
  }
})
