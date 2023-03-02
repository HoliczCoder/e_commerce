const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const createAttributeGroup = async (req, res) => {
  try {
    console.log(req.body.group_name);
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

module.exports = {
  createAttributeGroup,
};
