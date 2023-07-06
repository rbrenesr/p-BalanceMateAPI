const { check } = require("express-validator");
const { response } = require('express');
const { validationResult } = require('express-validator');

const myValidationResult = (req, res = response, next) => {

    const errores = validationResult(req);
    
    if (!errores.isEmpty()) {
        return res.status(400).json({
            ok:false,
            errores
        });
    }

    next();
}

const validateInputDataLogin = [
    check("correo", "El email es requerido para realizar la autenticación").isEmail(),
    check("contrasena", "El password debe ser de mínimo 6 caracteres").isLength({ min: 6 }),
    myValidationResult
];

const validateInputDataNewUser = [
    check("name", "El nombre es requerido").not().isEmpty(),
    check("email", "El email es requerido").isEmail(),
    check("password", "El password debe ser de mínimo 6 caracteres").isLength({min: 6,}),
    myValidationResult
];


module.exports={ validateInputDataLogin, validateInputDataNewUser };