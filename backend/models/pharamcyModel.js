const mongoose = require('mongoose');

const pharamcySchema = mongoose.Schema({
    name:{
        type: String,
        required: [true, "please add the pharmacy name"]
    },
    email:{
        type: String,
        required: [true , "please add the pharmacy email address"]

    },
    phone:{
        type: String,
        required: [true, "please add the pharmacy phone number"]
    }
});

module.exports = mongoose.model("pharmacy", pharamcySchema);