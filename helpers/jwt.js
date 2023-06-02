const jwt = require('jsonwebtoken');
const { Promise } = require('mssql');

const generarJWT = (id, name) => {
    return new Promise((resolve, reject) => {
        const payload = { id, name };
        jwt.sign(payload, process.env.SECRET_JWT_SEED,{expiresIn:'1h'}, (err, token)=>{
            if(err){
                reject('No se logró generar el token');
            }

            resolve(token );
        })
    });
}

module.exports = { generarJWT };