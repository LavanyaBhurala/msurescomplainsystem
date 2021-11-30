const mysql = require('mysql')
const util = require('util')
const config = require('config')

const connection = mysql.createConnection(config.get('db-config'))

const db = (function () {
    const fetch = async (qry, vals = []) => {
        const query = util.promisify(connection.query).bind(connection)
        return await query(qry, vals)
    }

    const insert = async (qry, vals) => {
        const query = util.promisify(connection.query).bind(connection)
        return await query(qry, vals)
    }
    return {
        fetch: fetch,
        insert: insert
    }
})()

module.exports = db