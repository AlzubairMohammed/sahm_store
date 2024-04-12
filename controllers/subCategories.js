const { models } = require("../db/connection");
const ErrorResponse = require("../utils/errorResponse");
const fs = require("fs");
const path = require("path");
const asyncWrapper = require("../middleware/asyncWrapper");
const httpStatus = require("../utils/httpStatus");
const errorResponse = require("../utils/errorResponse");
const { validationResult } = require("express-validator");
const { sub_categories, categories } = models;

exports.getSubCategories = asyncWrapper(async (req, res) => {
  const data = await sub_categories.findAll({
    include: ["category"],
  });
  res.json({ status: httpStatus.SUCCESS, data });
});

exports.getSubCategory = asyncWrapper(async (req, res, next) => {
  const id = req.params.id;
  const data = await sub_categories.findOne({
    where: { id },
    include: ["category"],
  });
  if (!data) {
    const error = ErrorResponse.create(
      `subCategory with id = ${id} is not found`,
      404,
      httpStatus.FAIL
    );
    return next(error);
  }
  return res.json({ status: httpStatus.SUCCESS, data });
});

exports.createSubCategory = asyncWrapper(async (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const error = errorResponse.create(errors.array(), 400, httpStatus.FAIL);
    return next(error);
  }
  const data = await sub_categories.create(req.body);
  return res.json({ status: httpStatus.SUCCESS, data });
});

exports.updateSubCategory = asyncWrapper(async (req, res, next) => {
  const errors = validationResult(req);
  const id = req.params.id;
  if (!errors.isEmpty()) {
    const error = ErrorResponse.create(errors.array(), 400, httpStatus.FAIL);
    return next(error);
  }
  const [data] = await sub_categories.update(req.body, {
    where: { id },
  });
  if (!data) {
    const error = ErrorResponse.create(
      `subCategory with id = ${id} is not found`,
      404,
      httpStatus.FAIL
    );
    return next(error);
  }
  res.json({ status: httpStatus.SUCCESS, data: "Category updated" });
});

exports.deleteSubCategory = asyncWrapper(async (req, res, next) => {
  const id = req.params.id;
  const data = await sub_categories.destroy({ where: { id } });
  if (!data) {
    const error = ErrorResponse.create(
      `subCategory with id = ${id} is not found`,
      404,
      httpStatus.FAIL
    );
    return next(error);
  }
  return res.json({ status: httpStatus.SUCCESS, data: "Category deleted" });
});
