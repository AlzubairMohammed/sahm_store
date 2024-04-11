const router = require("express").Router();
const { productsValidator } = require("../validation/productsValidation");
const {
  getProducts,
  getProduct,
  createProduct,
  updateProduct,
  deleteProduct,
} = require("../controllers/products");

router.get("/", getProduct);
router.get("/:id", getProduct);
router.post("/", productsValidator(), createProduct);
router.put("/:id", productsValidator(), updateProduct);
router.delete("/:id", deleteProduct);

module.exports = router;
