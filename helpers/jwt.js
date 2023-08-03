const jwt = require('jsonwebtoken');
const { Promise } = require('mssql');

const generarJWT = (id, db) => {

    return new Promise((resolve, reject) => {
        const payload = { id, db };
        jwt.sign(payload, process.env.SECRET_JWT_SEED,{expiresIn:'5h'}, (err, token)=>{
            if(err){
                reject('No se logró generar el token');
            }

            resolve(token );
        })
    });
}

module.exports = { generarJWT };