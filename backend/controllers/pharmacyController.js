//@desc get all pharmacies
//@route Get /api/pharmacy
//@access public 


const asyncHandler = require("express-async-handler");
const pharmacy = require('../models/pharamcyModel');

const getPharamcies = asyncHandler(async(req,res)=> {
    const pharmacies = await pharmacy.find();
    res.status(200).json(pharmacies)
})

const getPharmacyById = asyncHandler(async(req,res)=>{
    const single_pharmacy = await pharmacy.findById(req.params.id)

    if(!contact){
        res.status(404);
        throw new Error("Contact not found")
    }
    res.status(200).json(single_pharmacy)
})

const createPharmacy = asyncHandler(async(req,res)=>{
    console.log("the request body is:", req.body);
    const {name,email,phone} = req.body
    if(!name || !email || !phone){
        res.status(400);
        throw new Error("All fields are mandotary")
    }
    
    const pharmacy_object = await pharmacy.create({
        name,
        email,
        phone,
    });
    res.status(201).json(pharmacy_object)
})


const putPharmacy= (req,res)=> {
    res.status(200).json({message: `update pharmacy for ${req.params.id}`})
}


const deletePharmacy = (req,res)=>{
    res.status(200).json({message: `delete pharmacy with id ${req.params.id}`})
}

module.exports = {getPharamcies , createPharmacy , putPharmacy , deletePharmacy , getPharmacyById   }