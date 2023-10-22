const errorHandler = (err,req,res,next)=>{
const statusCode = res.statusCode ? res.statusCode : 500;

const {constants} = require('../middleware/constants')

    switch(statusCode){
        case constants.VALIDATION_ERROR: 
            res.json({
                title: "Validation Failed - custom ",
                message: err.message,
                stacktrace : err.stacktrace
            })
            break;
        case constants.NOT_FOUND:
            res.json({
                title: "Not Found - custom ",
                message: err.message,
                stackTrace: err.stackTrace,
            });

        case constants.FORBIDDEN:
            res.json({
                title: "forbidden - custom",
                message: err.message,
                stacktrace: err.stackTrace
            })

        case constants.SERVER_ERROR:
            res.json({
                    title: "server error - custom",
                    message: err.message,
                    stacktrace: err.stackTrace
                })
        
        default:
            console.log("No error , all work ")
            break;
    }
    // res.json({message: err.message, stackTrace : err.stackTrace})

};


module.exports = errorHandler;