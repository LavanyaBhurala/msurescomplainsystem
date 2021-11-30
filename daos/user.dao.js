const db = require('../utils/db.util')

const userDao = (() => {

    const add = async (user) => {
        let userId
        const result = await db.insert('insert into users (name, email, password, mobile, type_id) values (?, ?, ?, ?, ?)', [user.name, user.email, user.password, user.mobile, user.type_id])
        if (result) {
            userId = result.insertId
        }
        return userId
    }

    const findById = async (id) => {
        let user
        const result = await db.fetch('select usr.* from users usr where id = ? limit 1', [id])
        if (result) {
            user = result[0]
        }
        return user
    }

    const findByCred = async (email, password) => {
        let user
        const result = await db.fetch('select usr.* from users usr where email = ? and password = ? and is_active = "Y" and is_deleted = "N" limit 1', [email, password])
        if (result) {
            user = result[0]
        }
        return user
    }

    const findByEmail = async (email) => {
        let user
        const result = await db.fetch('select usr.* from users usr where email = ? and is_active = "Y" and is_deleted = "N" limit 1', [email])
        if (result) {
            user = result[0]
        }
        return user
    }

    const findByType = async (type) => {
        let users
        const typeId = getTypeIdByDesc(type)
        const results = await db.fetch('select id, name from users usr where type_id = ? and is_active = "Y" and is_deleted = "N"', [typeId])
        if (results) {
            users = {}
            for (const result of results) {
                users[result.id] = {
                    name: result.name,
                    email: result.email,
                    mobile: result.mobile
                }
            }

        }
        return users
    }

    return {
        add: add,
        findById: findById,
        findByCred: findByCred,
        findByEmail: findByEmail,
        findByType: findByType
    }
})()

module.exports = userDao