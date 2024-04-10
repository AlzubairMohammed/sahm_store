const router = require("express").Router();
const {
  subCategoryValidation,
} = require("../validation/subCategoryValidation");
const {
  getSubCategories,
  createSubCategory,
  updateSubCategory,
  deleteSubCategory,
  getSubCategory,
} = require("../controllers/subCategories");

router.get("/", getSubCategories);
router.get("/:id", getSubCategory);
router.post("/", subCategoryValidation(), createSubCategory);
router.put("/:id", subCategoryValidation(), updateSubCategory);
router.delete("/:id", deleteSubCategory);

module.exports = router;
