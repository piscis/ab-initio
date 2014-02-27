express = require("express");

app = express();
app.use '/', express.static(__dirname+'/public')
app.listen process.env.PORT, ()->
  console.log "Server listening on port #{process.env.PORT}"
