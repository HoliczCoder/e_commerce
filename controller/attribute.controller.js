const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const type = ["Text", "Select", "Multiselect", "Textarea"];

const createAttributeGroup = async (req, res) => {
  try {
    const attributeGroup = await prisma.atrributeGroup.create({
      data: {
        group_name: req.body.group_name,
      },
    });
    res.status(200).json({
      result: attributeGroup.group_name,
    });
  } catch (error) {
    res.status(500).json({
      error: error,
    });
  }
};

const createAttribute = async (req, res) => {
  try {
    if (!type.includes(req.body.type)) {
      res.status(400).json({
        res: "incorrect type",
      });
    }
    const atrribute = await prisma.atrribute.create({
      data: {
        attribute_code: req.body.attribute_code,
        attribute_name: req.body.attribute_name,
        type: req.body.type,
        is_required: req.body.is_required,
        display_on_frontend: req.body.display_on_frontend,
        sort_order: req.body.sort_order,
        is_filterable: req.body.is_filterable,
      },
    });
  } catch (error) {
    res.status(500).json({
      error: error,
    });
  }
};

module.exports = {
  createAttributeGroup,
};
