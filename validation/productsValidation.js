const { body } = require("express-validator");

exports.productsValidator = () => {
  return [
    body("name")
      .notEmpty()
      .withMessage("name is required")
      .isLength({ min: 2 })
      .withMessage("name at least is 2 digits"),
    body("buy_price").notEmpty().withMessage("base_price is required"),
    body("sale_price").notEmpty().withMessage("base_price is required"),
    body("sub_category_id").notEmpty().withMessage("category is required"),
  ];
};
