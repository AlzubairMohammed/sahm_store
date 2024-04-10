const router = require("express").Router();
const { categoriesValidation } = require("../validation/categoriesValidation");
const {
  getCategories,
  createCategory,
  updateCategory,
  deleteCategory,
  getCategory,
} = require("../controllers/categories");

router.get("/", getCategories);
router.get("/:id", getCategory);
router.post("/", categoriesValidation(), createCategory);
router.put("/:id", categoriesValidation(), updateCategory);
router.delete("/:id", deleteCategory);

module.exports = router;
