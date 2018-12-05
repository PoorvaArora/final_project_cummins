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
      if(clientId == 9862 && engineId == 1002){
          this.failureAlert = true;
          this.successAlert = false;
      }
      else {
        this.successAlert = true;
        this.failureAlert = false;
      }
    },
  },
  created () {
    this.fetchClients();
  }
})
