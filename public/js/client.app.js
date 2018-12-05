var agsApp = new Vue({
  el: '#agsClient',
  data: {
    clients:[],
    successAlert: false,
    failureAlert: false
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
          failureAlert = true;
          successAlert = false;
      }
      else {
        successAlert = true;
        failureAlert = true;
      }
    },
  },
  created () {
    this.fetchClients();
  }
})
