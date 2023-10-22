const express = require('express');
const router = express.Router();
const pharmacy= require('../controllers/pharmacyController')



router.route("/").get(pharmacy.getPharamcies).post(pharmacy.createPharmacy)
router.route("/:id").put(pharmacy.putPharmacy).delete(pharmacy.deletePharmacy).get(pharmacy.getPharmacyById)


// router.route("/").get(pharmacy.getPharamcies);
// router.route("/").post(pharmacy.createPharmacy)
// router.route("/:id").put(pharmacy.putPharmacy)
// router.route("/:id").delete(pharmacy.deletePharmacy)


module.exports = router