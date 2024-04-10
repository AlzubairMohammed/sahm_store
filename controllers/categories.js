const { connection } = require("../db/connection");
const ErrorResponse = require("../utils/errorResponse");
const fs = require("fs");
const path = require("path");
const asyncWrapper = require("../middleware/asyncWrapper");
const httpStatus = require("../utils/httpStatus");
const errorResponse = require("../utils/errorResponse");
const { validationResult } = require("express-validator");
const { categories } = connection;

exports.getCategories = asyncWrapper(async (req, res) => {
  const data = await categories.findAll({
    include: ["sub_categories"],
  });
  res.json({ status: httpStatus.SUCCESS, data });
});

exports.getCategory = asyncWrapper(async (req, res, next) => {
  const id = req.params.id;
  const data = await categories.findOne({
    where: { id },
    include: ["sub_categories"],
  });
  if (!data) {
    const error = ErrorResponse.create(
      `Category with id = ${id} is not found`,
      404,
      httpStatus.FAIL
    );
    return next(error);
  }
  return res.json({ status: httpStatus.SUCCESS, data });
});

exports.createCategory = async (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const error = errorResponse.create(errors.array(), 400, httpStatus.FAIL);
    return next(error);
  }
  const data = await categories.create(req.body);
  return res.json({ status: httpStatus.SUCCESS, data });
};

exports.updateCategory = asyncWrapper(async (req, res, next) => {
  const errors = validationResult(req);
  const id = req.params.id;
  if (!errors.isEmpty()) {
    const error = ErrorResponse.create(errors.array(), 400, httpStatus.FAIL);
    return next(error);
  }
  const [data] = await categories.update(req.body, {
    where: { id },
  });
  if (!data) {
    const error = ErrorResponse.create(
      `Category with id = ${id} is not found`,
      404,
      httpStatus.FAIL
    );
    return next(error);
  }
  res.json({ status: httpStatus.SUCCESS, data: "Category updated" });
});

exports.deleteCategory = asyncWrapper(async (req, res, next) => {
  const id = req.params.id;
  const data = await categories.destroy({ where: { id } });
  if (!data) {
    const error = ErrorResponse.create(
      `Category with id = ${id} is not found`,
      404,
      httpStatus.FAIL
    );
    return next(error);
  }
  return res.json({ status: httpStatus.SUCCESS, data: "Category deleted" });
});
