const express = require('express');
const empresaRouter = express.Router();

const { validarJWT } = require('../middlewares/validarJWT');
const {
    validateInputDataEmpresa,    
} = require('../middlewares/validateInputData');
const { nuevoEmpresa, obtenerEmpresa, actualizarEmpresa, eliminarEmpresa } = require("../controllers/empresaController");

empresaRouter.use(validarJWT);
empresaRouter.post('/', validateInputDataEmpresa, nuevoEmpresa);
empresaRouter.get('/:clave?/:valor?', obtenerEmpresa);
empresaRouter.put('/:id',validateInputDataEmpresa,  actualizarEmpresa);
empresaRouter.delete('/:id', eliminarEmpresa);

module.exports = { empresaRouter };