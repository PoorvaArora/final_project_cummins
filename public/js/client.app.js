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
      if(clientId == 10024 && engineId == 1001){
          $('#failureModal').modal('show');
      }
      else {
          $('#successModal').modal('show');
      }
    },
    checkDetails(sensorId,clientId,engineId){
      window.location.replace("kpi.html?sensorId"+sensorId+"&clientId"+clientId+"&engineId"+engineId);
    }
  },
  created () {
    this.fetchClients();
  }
})
