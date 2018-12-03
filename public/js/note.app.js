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
      fetch('api/note.php')
      .then( response => response.json() )
      // ^ This is the same as .then( function(response) {return response.json()} )
      .then( json => {notesApp.notes = json})
      .catch( err => {
        console.log('NOTE FETCH ERROR:');
        console.log(err);
      })
    },
    fetchClients () {
      fetch('api/client.php')
      .then( response => response.json() )
      // ^ This is the same as .then( function(response) {return response.json()} )
      .then( json => {notesApp.clients = json})
      .catch( err => {
        console.log('TASK FETCH ERROR:');
        console.log(err);
      })
    },
    handleNoteForm(e) {
      const s = JSON.stringify(this.noteForm);
      console.log(s);
      // POST to remote server
      fetch('api/note.php', {
        method: "POST", // *GET, POST, PUT, DELETE, etc.
        headers: {
          "Content-Type": "application/json; charset=utf-8"
        },
        body: s // body data type must match "Content-Type" header
      })
      .then(response => response.json())
      .then(json => {
        this.notes.push(json)
      })
      .catch(err => {
        console.error('NOTE POST ERROR:');
        console.error(err);
      });
      this.noteForm = this.getEmptyNoteForm();
    },
    getEmptyNoteForm() {
      return {
        note: ''
      }
    },
  },
  created () {
    this.fetchNotes();
    this.fetchClients();
  }
})
