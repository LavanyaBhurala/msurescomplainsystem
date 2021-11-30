const express = require("express");

const router = express.Router();

const businessController = require("../controllers/business.controller");

router.get("/home", (req, res) => {
  businessController.home(req, res);
});

router.get("/about-us", (req, res) => {
  businessController.aboutUs(req, res);
});

router.get("/location", (req, res) => {
  businessController.location(req, res);
});

router.get("/feedback", (req, res) => {
  businessController.feedback(req, res);
});

router.get("/ticket", (req, res) => {
  businessController.ticketForm(req, res);
});

router.get("/ticket/:id", (req, res) => {
  businessController.ticketDetail(req, res);
});

router.post("/ticket", async (req, res) => {
  await businessController.createTicket(req, res);
});

router.put("/ticket", async (req, res) => {
  await businessController.updateTicket(req, res);
});

module.exports = router;
