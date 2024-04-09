const router = require("express").Router();
const { categoriesValidation } = require("../validation/categoriesValidation");
const {
  getCategories,
  createCategory,
  updateCategory,
  deleteCategory,
  getCategory,
} = require("../controllers/categories");

const fileUpload = require("express-fileupload");

router.get("/", getCategories);
router.get("/:id", getCategory);
router.post(
  "/",
  fileUpload({ createParentPath: true }),
  categoriesValidation(),
  createCategory
);
router.put(
  "/:id",
  fileUpload({ createParentPath: true }),

  categoriesValidation(),
  updateCategory
);
router.delete("/:id", deleteCategory);

module.exports = router;
