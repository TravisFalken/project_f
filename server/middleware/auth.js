const ErrorResponse = require("../utils/ErrorResponse");
const asyncHandler = require("./asyncHandler");
const jwt = require('../utils/webToken');
const userQueries = require("../queries/userQueries");

exports.protect = asyncHandler(async (req, res, next) => {
    let token;

    if(
        req.headers.authorization &&
        req.headers.authorization.startsWith('Bearer')
    ){
        token = req.headers.authorization.split(' ')[1];
    }

    if(!token){
        return next(new ErrorResponse('Not authorized to access this route', 401));
    }

    try {
        //decode the jwt token
        const decoded = await jwt.decodeWebToken(token);

        if(decoded == 'expired'){
            return next(new ErrorResponse('Session has expired', 401));
        }

        const user = await userQueries.getUserQuery(decoded.id);
        req.user = user;
        next();
    }catch(e){
        return next(new ErrorResponse('Not Authorized to access', 401));
    }
})