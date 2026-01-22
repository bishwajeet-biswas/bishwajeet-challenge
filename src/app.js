const dotenv = require("dotenv");
const express = require("express");

dotenv.config();

const app = express();
app.use(express.json());
app.use("/", (req, res) => {
  res.send("Server is running");
});

const port = process.env.port || 3000;

app.listen(port, () => console.log("Server listening on port 3000"));
