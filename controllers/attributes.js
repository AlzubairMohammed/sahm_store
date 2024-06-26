const { sequelize, models } = require("../db/connection");
const ErrorResponse = require("../utils/errorResponse");
const asyncWrapper = require("../middleware/asyncWrapper");
const httpStatus = require("../utils/httpStatus");
const errorResponse = require("../utils/errorResponse");
const { validationResult } = require("express-validator");
const { attributes, attribute_options } = models;

exports.createAttribute = asyncWrapper(async (req, res, next) => {
  let transaction;
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const error = errorResponse.create(errors.array(), 400, httpStatus.FAIL);
    return next(error);
  }
  transaction = await sequelize.transaction();
  // return res.json(req.body.name);
  const data = await attributes.create(req.body, { transaction });
  req.body.options.forEach(
    asyncWrapper(async (element) => {
      await attribute_options.bulkCreate(
        { attributeId: data.id, name: element },
        { transaction }
      );
    })
  );
  await transaction.commit();
  return res.json({ status: httpStatus.SUCCESS, data });
});

exports.getAttributes = asyncWrapper(async (req, res) => {
  const data = await attributes.findAll();
  res.json({ status: httpStatus.SUCCESS, data });
});

exports.getAttribute = asyncWrapper(async (req, res, next) => {
  const id = req.params.id;
  const data = await attributes.findOne({
    where: { id },
    include: {
      model: attribute_options,
      as: "attribute_options",
    },
  });
  if (!data) {
    const error = ErrorResponse.create(
      `Attribute with id = ${id} is not found`,
      404,
      httpStatus.FAIL
    );
    return next(error);
  }
  return res.json({ status: httpStatus.SUCCESS, data });
});

exports.updateAttribute = asyncWrapper(async (req, res, next) => {
  const errors = validationResult(req);
  const id = req.params.id;
  if (!errors.isEmpty()) {
    const error = ErrorResponse.create(errors.array(), 400, httpStatus.FAIL);
    return next(error);
  }
  const [data] = await attributes.update(req.body, {
    where: { id },
  });
  if (!data) {
    const error = ErrorResponse.create(
      `Attribute with id = ${id} is not found`,
      404,
      httpStatus.FAIL
    );
    return next(error);
  }
  res.json({ status: httpStatus.SUCCESS, data: "Attribute updated" });
});

exports.deleteAttribute = asyncWrapper(async (req, res, next) => {
  const id = req.params.id;
  const data = await attributes.destroy({ where: { id } });
  if (!data) {
    const error = ErrorResponse.create(
      `Attribute with id = ${id} is not found`,
      404,
      httpStatus.FAIL
    );
    return next(error);
  }
  return res.json({ status: httpStatus.SUCCESS, data: "Attribute deleted" });
});
