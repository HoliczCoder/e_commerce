const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const createCategory = async (req, res) => {
  try {
    const category = await prisma.category.create({
      data: {
        status: req.body.status,
        parent_id: req.body.parent_id,
        include_in_nav: req.body.include_in_nav,
        position: req.body.position,
      },
    });
    const categoryDescription = await prisma.categoryDescription.create({
      data: {
        category_description_category_id: category.category_id,
        name: req.body.name,
        short_description: req.body.short_description,
        description: req.body.description,
        meta_title: req.body.meta_title,
        image: req.body.image,
        meta_keywords: req.body.meta_keywords,
        meta_description: req.body.meta_description,
        url_key: req.body.url_key,
      },
    });
    res.status(200).json({
      res: {
        category,
        categoryDescription,
      },
    });
  } catch (error) {
    res.status(500).json({
      error: error,
    });
  }
};

module.exports = {
  createCategory,
};
