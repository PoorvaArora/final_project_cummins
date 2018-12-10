var notesApp = new Vue({
  el: '#agsNotes',
  data: {
    notes:[],
    noteForm: { },
    clients: []
  },
  computed: {
  },
  methods: {
    fetchNotes () {
      var clientId = 10024;
      fetch('api/note.php?clientId='+clientId)
      .then( response => response.json() )
      // ^ This is the same as .then( function(response) {return response.json()} )
      .then( json => {notesApp.notes = json})
      .catch( err => {
        console.log('NOTE FETCH ERROR:');
        console.log(err);
      });
    },
  },
  created () {
    this.fetchNotes();
  }
})
