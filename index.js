const express = require("express");
const app = express();
require("dotenv").config();
const categories = require("./routes/categories");
const attributes = require("./routes/attributes");
// const variations = require("./routes/variations");
const prodcuts = require("./routes/products");
const subCategories = require("./routes/subCategories");
const users = require("./routes/users");
const httpStatus = require("./utils/httpStatus");
const fileUpload = require("express-fileupload");

app.use(fileUpload());
app.use(express.json({ limit: "50mb" }));

const cors = require("cors");
app.use(
  cors({
    origin: "*",
  })
);

const URL = process.env.ROUTES_URL;
app.use(`${URL}/categories/`, categories);
app.use(`${URL}/attributes/`, attributes);
// app.use(`${URL}/variations/`, variations);
app.use(`${URL}/products/`, prodcuts);
app.use(`${URL}/subCategories/`, subCategories);
app.use(`${URL}/users/`, users);

app.use(express.static("."));
// global error handler
app.use((error, req, res, next) => {
  res.status(error.statusCode || 500).json({
    status: error.statusText || httpStatus.ERROR,
    message: error.message,
    code: error.statusCode || 500,
    data: null,
  });
});

const PORT = process.env.PORT || 8000;
app.listen(PORT, async () => {
  console.log(`app running at ${PORT}`);
});
