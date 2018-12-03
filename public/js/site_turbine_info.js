var agsApp = new Vue({
  el: '#agsSiteTurbine',
  data: {
    sitesTurbs:[],
    turbines:[],
    sites:[],
    isTurbineDisplay:false,
    isSiteDisplay:false
  },
  computed: {
  },
  methods: {
    fetchTurbineSite () {
      fetch('api/turbineDeployed.php')
      .then( response => response.json() )
      // ^ This is the same as .then( function(response) {return response.json()} )
      .then( json => {agsApp.sitesTurbs = json})
      .catch( err => {
        console.log('TASK FETCH ERROR:');
        console.log(err);
      })
    },
    showTurbineDetails(turbineId){
      fetch('api/turbine.php?turbineId='+turbineId)
      .then( response => response.json() )
      // ^ This is the same as .then( function(response) {return response.json()} )
      .then( json => {agsApp.turbines = json;
        agsApp.isTurbineDisplay = true;
      })
      .catch( err => {
        console.log('TURBINE FETCH ERROR:');
        console.log(err);
      })
    },
    showSiteDetails(siteId){
      fetch('api/site.php?siteId='+siteId)
      .then( response => response.json() )
      // ^ This is the same as .then( function(response) {return response.json()} )
      .then( json => {agsApp.sites = json;
        agsApp.isSiteDisplay = true;
      })
      .catch( err => {
        console.log('SITE FETCH ERROR:');
        console.log(err);
      })
    },
    hideTurbineDetails(){
      this.isTurbineDisplay = false;
    },
    hideSiteDetails(){
      this.isSiteDisplay = false;
    }
  },
  created () {
    this.fetchTurbineSite();
  }
})
