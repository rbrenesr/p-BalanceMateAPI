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

const validateInputDataNuevoUsuario = [
    check("correo", "El email es requerido").isEmail(),
    check("contrasena", "El password debe ser de mínimo 6 caracteres").isLength({min: 6,}),
    check("nombre", "El nombre es requerido").not().isEmpty(),
    myValidationResult
];

const validateInputDataNuevoEmpresa = [
    check("correo", "El email es requerido").isEmail(),
    check("contrasena", "El password debe ser de mínimo 6 caracteres").isLength({min: 6,}),
    check("nombre", "El nombre es requerido").not().isEmpty(),
    myValidationResult
];




module.exports={ validateInputDataLogin, validateInputDataNuevoUsuario, validateInputDataNuevoEmpresa};