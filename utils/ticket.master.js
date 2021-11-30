const db = require('./db.util')

const ticketMaster = (() => {

    const TICKET_STATUSES = {}
    const TICKET_ACTIONS = {}

    const init = () => {
        (async () => {
            let results = await db.fetch("select * from ticket_status_master")
            for (const result of results) {
                TICKET_STATUSES[result.id] = {
                    title: result.title,
                    desc: result.desc
                }
            }
            results = await db.fetch("select * from ticket_action_master")
            for (let result of results) {
                TICKET_ACTIONS[result.id] = {
                    title: result.title,
                    desc: result.desc
                }
            }
        })()
    }

    init()

    const getStatusId = (desc) => {
        let id
        for (const _id in TICKET_STATUSES) {
            if (TICKET_STATUSES[_id].title == desc) {
                id = _id
            }
        }
        return id
    }

    const getStatusDesc = (id) => {
        let desc
        const status = TICKET_STATUSES[id]
        if (status) {
            desc = status.title
        }
        return desc
    }

    const getActionId = (desc) => {
        let id
        for (const _id in TICKET_ACTIONS) {
            if (TICKET_ACTIONS[_id].title == desc) {
                id = _id
            }
        }
        return id
    }

    const getActionDesc = (id) => {
        let desc
        const action = TICKET_ACTIONS[id]
        if (action) {
            desc = action.title
        }
        return desc
    }

    return {
        getStatusId: getStatusId,
        getStatusDesc: getStatusDesc,
        getActionId: getActionId,
        getActionDesc: getActionDesc
    }
})()

module.exports = ticketMaster