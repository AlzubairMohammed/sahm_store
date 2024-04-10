const router = require("express").Router();

const {
  getUsers,
  getUser,
  register,
  login,
  updateUser,
  deleteUser,
} = require("../controllers/users");

router.get("/", getUsers);
router.get("/:id", getUser);
router.post("/", register);
router.post("/login", login);
router.put("/:id", updateUser);
router.delete("/:id", deleteUser);

module.exports = router;
