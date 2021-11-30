const db = require('../utils/db.util')

const constant = require('../utils/constant.util')
const ticketMaster = require('../utils/ticket.master')

const userDao = require('../daos/user.dao')
const moment = require('moment');


const ticketDao = (() => {

    const add = async (ticket) => {
        let ticketId
        const result = await db.fetch("insert into tickets (title, `desc`, user_id, status_id) values (?, ?, ?, ?)", [ticket.title, ticket.desc, ticket.userId, ticketMaster.getStatusId(constant.CREATED)])
        if (result) {
            ticketId = result.insertId
            log(ticket.userId, ticketId, constant.CREATED)
        }
        return ticketId
    }

    const update = async (ticket) => {
        let updated = false
        const result = await db.fetch("update tickets set title = ? and `desc` = ? where id = ?", [ticket.title, ticket.desc, ticket.id])
        if (result) {
            log(ticket.userId, ticket.id, constant.UPDATED)
            updated = true
        }
        return updated
    }

    const assign = async (ticketId, userId) => {
        await db.fetch("update ticket_assignee_mappings set is_active = 'N'  where ticket_id = ?", [ticketId])
        await db.fetch("insert into ticket_assignee_mappings (ticket_id, user_id) values (?, ?)", [ticketId, userId])
        log(userId, ticketId, constant.ASSIGNED)
    }

    const getAssignee = async (ticketId) => {
        let user
        let results = await db.fetch("select user_id from ticket_assignee_mappings where ticket_id", [ticketId])
        if (results && results.length > 0) {
            let userId = results[0].user_id
            user = userDao.findById(userId)
        }
        return user
    }

    const search = async (criteria) => {
        const tickets = []

        const query = ["select * from tickets where 1=1"]

        const params = []

        let results = []

        if (criteria.assignee) {
            results = db.fetch("select ticket_id from ticket_assignee_mappings where user_id = ? and is_active='Y'", [criteria.assignee])
            if (results) {
                const ticketIds = results.map(result => { return result.ticket_id })
                query.push("and ids in (?)")
                params.push(ticketIds.join(","))
            }
        } else if (criteria.id) {
            query.push("and id = ?")
            params.push(criteria.id)
        } else {
            if (criteria.loggedBy) {
                query.push("and user_id = ?")
                params.push(criteria.loggedBy)
            }
        }
        query.push("order by updated_at desc")

        let limit = criteria.limit || 20

        query.push("limit " + limit)
        query.push("offset " + (criteria.page || 0) * limit)

        results = await db.fetch(query.join(" "), params)
        if (results && results.length > 0) {
            for (const result of results) {
                tickets.push(await prepInfo(result))
            }
        }

        return tickets
    }

    const prepInfo = async (ticket) => {
        const ticketInfo = {}

        ticketInfo.id = ticket.id
        ticketInfo.title = ticket.title
        ticketInfo.desc = ticket.desc

        let user = await userDao.findById(ticket.user_id)
        ticketInfo.loogedBy = user.name

        user = await getAssignee(ticket.id)
        if (user) {
            ticketInfo.assignee = user.name
        }

        ticketInfo.status = ticketMaster.getStatusDesc(ticket.status_id)
        ticketInfo.createdOn = moment(ticket.created_at).format('MMMM d, YYYY')
        ticketInfo.modifiedOn = moment(ticket.updated_at).format('MMMM d, YYYY')

        return ticketInfo
    }

    const log = async (userId, ticketId, action) => {
        await db.fetch("insert into ticket_action_logs (user_id, ticket_id, action_id) values (?, ?, ?)", [userId, ticketId, ticketMaster.getActionId(action)])
    }

    return {
        add: add,
        update: update,
        search: search,
        assign: assign
    }
})()

module.exports = ticketDao