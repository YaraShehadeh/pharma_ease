const express = require("express");
const errorHandler = require("./middleware/errorHandler");
const connectDb = require("./config/dbConnection");
const dotenv = require('dotenv').config()


connectDb();
const port = process.env.PORT || 5000;

const app = express()

app.use(express.json())
app.use("/api/pharmacy", require("./routes/contactRoutes"))
app.use(errorHandler);

app.listen(port, ()=>{
    console.log(`server running on port ${port}`)
})
