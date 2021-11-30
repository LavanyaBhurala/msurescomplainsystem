const userDao = require('../daos/user.dao')

const authController = (() => {
    const registration = (() => {
        const form = (req, res) => {
            res.render('pages/registration')
        }
        const post = async (req, res) => {
            const user = await userDao.findByEmail(req.body.email)
            if (user) {
                res.redirect(config.get('app-context') + '/register', { message: 'User with email <' + req.body.email + '> already exist' })
            } else {
                const userId = await userDao.add(req.body)
                const user = await userDao.findById(userId)
                if (userId && userId > 0) {
                    _session(user, req.session)
                    res.render('pages/home', {name : user.name})
                }
            }
        }
        return {
            form: form,
            post: post
        }
    })()

    const login = (() => {
        const form = (req, res) => {
            res.render('pages/login')
        }
        const post = async (req, res) => {
            const user = await userDao.findByCred(req.body.email, req.body.password)
            if (user) {
                _session(user, req.session)
                res.redirect('home')
            }
            else {
                res.render('pages/login', { message: 'Invalid Email Or Password' })
            }
        }
        return {
            form: form,
            post: post
        }
    })()

    const _session = (user, session) => {
        session.email = user.email
        session.name = user.name
        session.userId = user.id
        session.typeId = user.type_id
    }

    return {
        login: login,
        registration: registration
    }
})()

module.exports = authController