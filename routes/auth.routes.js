const express = require('express')

const router = express.Router()
const authController = require('../controllers/auth.controller')

router.get('/register', (req, res) => {
    authController.registration.form(req, res)
})

router.post('/register', async (req, res) => {
    await authController.registration.post(req, res)
})

router.get('/login', (req, res) => {
    authController.login.form(req, res)
})

router.post('/login', async (req, res) => {
    await authController.login.post(req, res)
})

router.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('login');
});

module.exports = router