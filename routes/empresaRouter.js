const express = require('express');
const empresaRouter = express.Router();

const { validarJWT } = require('../middlewares/validarJWT');
const {
    validateInputDataNuevoEmpresa,    
} = require('../middlewares/validateInputData');
const { nuevoEmpresa, obtenerEmpresa, actualizarEmpresa, eliminarEmpresa } = require("../controllers/empresaController");

empresaRouter.use(validarJWT);

// empresaRouter.post('/', validateInputDataNuevoEmpresa, nuevoEmpresa);
empresaRouter.post('/', nuevoEmpresa);
empresaRouter.get('/:clave?/:valor?', obtenerEmpresa);
empresaRouter.put('/:id', actualizarEmpresa);
empresaRouter.delete('/:id', eliminarEmpresa);

module.exports = { empresaRouter };