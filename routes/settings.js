const express = require('express');
const settings = express.Router();

const { validarJWT } = require('../middlewares/validarJWT');
const { validateInputDataLogin, validateInputDataNewUser } = require('../middlewares/validateInputData');

const { login, newUser, renewToken, getEmpresas } = require("../controllers/auth");


settings.post('/',validateInputDataLogin, login);
settings.post('/new', validateInputDataNewUser, newUser);


settings.get('/renew', validarJWT, renewToken);
settings.get('/empresas', getEmpresas);

module.exports = { settings };