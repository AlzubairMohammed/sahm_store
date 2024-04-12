// function to convert base64 to file
const fs = require("fs");
exports.handleImageBase64 = (base64Data, path) => {
  const matches = base64Data.match(/^data:image\/([A-Za-z-+/]+);base64,(.+)$/);

  if (!matches || matches.length !== 3) {
    return res.status(400).json({ message: "Invalid Base64 image data" });
  }

  const fileExtension = matches[1];
  const base64Image = matches[2];
  const fileName = Date.now() + "." + fileExtension;
  const filePath = path + fileName;
  fs.writeFile(`uploads/${filePath}`, base64Image, "base64", (err) => {
    if (err) {
      return res.status(500).json({ message: "Error saving image" });
    }
  });
  return filePath;
};
