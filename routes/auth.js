const express = require('express');
const auth = express.Router();

const { validarJWT } = require('../middlewares/validarJWT');
const { validateInputDataLogin, validateInputDataNewUser } = require('../middlewares/validateInputData');

const { login, newUser, renewToken, getEmpresas } = require("../controllers/auth");


auth.post('/',validateInputDataLogin, login);
auth.post('/new', validateInputDataNewUser, newUser);


auth.get('/renew', validarJWT, renewToken);
auth.get('/empresas', getEmpresas);

module.exports = { auth };