const jwt = require('jsonwebtoken');

//@desc creates a new json web token
const createWebToken = async (user) => {
    return new Promise(async (resolve, reject) => {
        try{
            const token = await jwt.sign(
                {
                    id: user.userID
                },
                process.env.JWT_SECRET,
                {
                    expiresIn: process.env.JWT_EXPIRE
                }
            );
            resolve(token);
        }catch(e){
            reject(e);
        }
    });
}

const decodeWebToken = async (token) => {
    return new Promise(async (resolve, reject) => {
        try{
            const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
            resolve(decodedToken);
        }catch(e){
            if(e.message == 'jwt expired'){
                resolve('expired');
            } else {
                reject(e);
            }
        }
    });
}

module.exports = {
    createWebToken,
    decodeWebToken
}