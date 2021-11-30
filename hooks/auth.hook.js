module.exports = (req, res, next) => {
    const loggedIn = req.session && req.session.email
    if (req.originalUrl.includes('/login') || req.originalUrl.includes('/register')) {
        if (loggedIn) {
            res.redirect('home')
        } else {
            next()
        }
    } else {
        if (loggedIn) {
            next()
        } else {
            res.redirect('login')
        }
    }
}