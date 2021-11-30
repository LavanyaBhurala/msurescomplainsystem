const ticketDao = require('../daos/ticket.dao');
const userMaster = require('../utils/user.master');
const constant = require('../utils/constant.util');
const helper = require('../utils/helper');

const businessController = (() => {
  const home = async (req, res) => {
    res.render('pages/home', {
      tickets: await homeTickets(req.session),
    });
  };

  const ticketForm = (req, res) => {
    res.render('pages/ticket-form');
  };

  const aboutUs = (req, res) => {
    res.render('pages/about-us');
  };

  const location = (req, res) => {
    res.render('pages/location');
  };

  const feedback = (req, res) => {
    res.render('pages/feedback');
  };

  const createTicket = async (req, res) => {
    const fields = req.body;
    fields.userId = req.session.userId;

    const ticketId = await ticketDao.add(fields);
    res.render('pages/home', {
      ticketId: ticketId,
      tickets: await homeTickets(req.session),
    });
  };

  const updateTicket = async (req, res) => {
    const fields = req.body;
    fields.userId = req.session.userId;

    const ticketId = await ticketDao.update(fields);
    res.render('pages/home', {
      ticketId: ticketId,
      updated: true,
      tickets: await homeTickets(req.session),
    });
  };

  const searchTickets = async (req, res) => {
    const tickets = await ticketDao.search(req.body);
    res.send({ tickets: tickets });
  };

  const ticketDetail = async (req, res) => {
    let ticket;
    const tickets = await ticketDao.search({
      id: req.params.id,
    });
    if (tickets) {
      ticket = tickets[0];
    }
    res.render('pages/ticket-detail', { ticket: ticket });
  };

  const homeTickets = async (session) => {
    let tickets;
    if (session.typeId) {
      let criteria = {};
      let type = userMaster.getTypeDescById(session.typeId);
      if (type.toUpperCase() == constant.STUDENT) {
        criteria['loggedBy'] = session.userId;
      } else if (type.toUpperCase() == constant.WORKER) {
        criteria['assignee'] = session.userId;
      }
      tickets = await ticketDao.search(criteria);
    }
    return tickets;
  };

  return {
    home: home,
    aboutUs: aboutUs,
    location: location,
    feedback: feedback,
    ticketForm: ticketForm,
    createTicket: createTicket,
    updateTicket: updateTicket,
    searchTickets: searchTickets,
    ticketDetail: ticketDetail,
  };
})();

module.exports = businessController;
