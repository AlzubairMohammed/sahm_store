const { models, sequelize } = require("../db/connection");
const ErrorResponse = require("../utils/errorResponse");
const asyncWrapper = require("../middleware/asyncWrapper");
const httpStatus = require("../utils/httpStatus");
const errorResponse = require("../utils/errorResponse");
const { validationResult } = require("express-validator");
const handleImageBase64 = require("../utils/handleImageBase64");
const {
  products,
  product_variations,
  product_images,
  product_variations_images,
  variation_attributes,
} = models;

exports.createProduct = asyncWrapper(async (req, res, next) => {
  let transaction;
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const error = errorResponse.create(errors.array(), 400, httpStatus.FAIL);
    return next(error);
  }
  transaction = await sequelize.transaction();
  const data = await products.bulkCreate(req.body, { transaction });
  req.body.variations.forEach(async (variation) => {
    await product_variations.bulkCreate(
      { product_id: data.id, variation },
      { transaction }
    );
    variation.images.forEach(async (image) => {
      // handle image base64
      const imageBase64 = image.image;
      const imagePath = handleImageBase64(imageBase64, "productsVariations");
      await product_variations_images.bulkCreate(
        { product_variation_id: variation.id, imagePath },
        { transaction }
      );
    });
    variation.attributes.forEach(async (attribute) => {
      await variation_attributes.bulkCreate(
        { product_variation_id: variation.id, attribute },
        { transaction }
      );
    });
  });
  await transaction.commit();
  return res.json({ status: httpStatus.SUCCESS, data });
});

exports.getProducts = asyncWrapper(async (req, res) => {
  const data = await products.findAll();
  res.json({ status: httpStatus.SUCCESS, data });
});

exports.getProduct = asyncWrapper(async (req, res, next) => {
  const id = req.params.id;
  const data = await products.findOne({
    where: { id },
  });
  if (!data) {
    const error = ErrorResponse.create(
      `Product with id = ${id} is not found`,
      404,
      httpStatus.FAIL
    );
    return next(error);
  }
  return res.json({ status: httpStatus.SUCCESS, data });
});

exports.updateProduct = asyncWrapper(async (req, res, next) => {
  const errors = validationResult(req);
  const id = req.params.id;
  if (!errors.isEmpty()) {
    const error = ErrorResponse.create(errors.array(), 400, httpStatus.FAIL);
    return next(error);
  }
  const [data] = await products.update(req.body, {
    where: { id },
  });
  if (!data) {
    const error = ErrorResponse.create(
      `Product with id = ${id} is not found`,
      404,
      httpStatus.FAIL
    );
    return next(error);
  }
  res.json({ status: httpStatus.SUCCESS, data: "Product updated" });
});

exports.deleteProduct = asyncWrapper(async (req, res, next) => {
  const id = req.params.id;
  const data = await products.destroy({ where: { id } });
  if (!data) {
    const error = ErrorResponse.create(
      `Product with id = ${id} is not found`,
      404,
      httpStatus.FAIL
    );
    return next(error);
  }
  return res.json({ status: httpStatus.SUCCESS, data: "Product deleted" });
});
