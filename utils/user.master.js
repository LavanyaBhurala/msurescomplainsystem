const db = require('./db.util')

const userMaster = (() => {

    const USER_TYPES = {}

    const init = () => {
        (async () => {
            const results = await db.fetch('select * from user_type_master')
            if (results) {
                for (const result of results) {
                    USER_TYPES[result.id] = {
                        title: result.title,
                        desc: result.desc
                    }
                }
            }
        })()
    }

    init()

    const getTypeDescById = (id) => {
        let desc
        if (USER_TYPES[id]) {
            desc = USER_TYPES[id].title
        }
        return desc
    }

    const getTypeIdByDesc = (desc) => {
        let id
        for (const _id in USER_TYPES) {
            if (USER_TYPES[_id].title == desc) {
                id = _id
            }
        }
        return id
    }

    return {
        getTypeDescById: getTypeDescById,
        getTypeIdByDesc: getTypeIdByDesc
    }
})()

module.exports = userMaster