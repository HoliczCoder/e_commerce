const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const _ = require("lodash");

const type = ["text", "select", "multiselect", "textarea"];

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
    const attributeData = req.body;
    //
    const atrribute = await prisma.atrribute.create({
      data: {
        attribute_code: attributeData.attribute_code,
        attribute_name: attributeData.attribute_name,
        type: attributeData.type,
        is_required: attributeData.is_required,
        display_on_frontend: attributeData.display_on_frontend,
        sort_order: attributeData.sort_order,
        is_filterable: attributeData.is_filterable,
      },
    });

    // find if hava a attribute group
    if (attributeData.groups === undefined) {
      res.status(200).json({
        res: atrribute,
      });
    }
    //
    const promises = [];

    for (let index = 0; index < attributeData.groups.length; index += 1) {
      const group = await prisma.atrributeGroup.findUnique({
        where: {
          attribute_group_id: attributeData.groups[index],
        },
      });
      if (group) {
        promises.push(
          prisma.attributeGroupLink.create({
            data: {
              attribute_id: atrribute.attribute_id,
              group_id: attributeData.groups[index],
            },
          })
        );
      }
    }
    //
    const result = await Promise.allSettled(promises);
    res.status(200).json({
      result: result,
    });
    //
  } catch (error) {
    res.status(500).json({
      error: error,
    });
  }
};

const updateAttribute = async (req, res) => {
  try {
    if (!type.includes(req.body.type)) {
      res.status(400).json({
        res: "incorrect type",
      });
    }
    const attributeData = req.body;
    // find if atrribute exist or not
    const isAtrributeExist = await prisma.atrribute.findUnique({
      where: {
        attribute_id: attributeData.attribute_id,
      },
    });
    if (!isAtrributeExist) {
      res.status(400).json({
        res: "this attribute not exist",
      });
      return;
    }
    //
    const atrribute = await prisma.atrribute.update({
      where: {
        attribute_id: attributeData.attribute_id,
      },
      data: {
        attribute_code: attributeData.attribute_code,
        attribute_name: attributeData.attribute_name,
        type: attributeData.type,
        is_required: attributeData.is_required,
        display_on_frontend: attributeData.display_on_frontend,
        sort_order: attributeData.sort_order,
        is_filterable: attributeData.is_filterable,
      },
    });
    // find if hava a attribute group
    if (attributeData.groups === undefined) {
      res.status(200).json({
        res: atrribute,
      });
    }
    // delete exist attribute_group_link if remove group
    const attribute_group_link = await prisma.attributeGroupLink.findMany({
      where: {
        attribute_id: attributeData.attribute_id,
      },
    });
    //
    if (!attribute_group_link) {
      // have to create new
      const promises = [];

      for (let index = 0; index < attributeData.groups.length; index += 1) {
        const group = await prisma.atrributeGroup.findUnique({
          where: {
            attribute_group_id: attributeData.groups[index],
          },
        });
        if (group) {
          promises.push(
            prisma.attributeGroupLink.create({
              data: {
                attribute_id: atrribute.attribute_id,
                group_id: attributeData.groups[index],
              },
            })
          );
        }
      }
      //
      const result = await Promise.allSettled(promises);
      res.status(200).json({
        result: result,
      });
      //
    }
    //
    //
    //
    // if attribute_group_link exist
    const promises = [];

    attribute_group_link.map(async (item) => {
      // this group id had been removed
      if (!attributeData.groups.includes(item.group_id)) {
        // remove it from db
        promises.push(
          prisma.attributeGroupLink.delete({
            where: {
              attribute_group_link_id: item.attribute_group_link_id,
            },
          })
        );
      }
    });
    // check if attributeData.groups have extra groupId
    const attributeId = atrribute.attribute_id;
    for (let index = 0; index < attributeData.groups.length; index += 1) {
      // find if group id is inside attribute_group_link group id
      const result = _.find(attribute_group_link, (item) =>
        _.has(item, "group_id", attributeData.groups[index])
      );
      if (!result) {
        // have to search if group exist?
        // const isGroupExist = await prisma.atrributeGroup.findFirst({
        //   where: {
        //     group_id: attributeData.groups[index],
        //   },
        // });
        //then must create new attribute_group_link
        if (isGroupExist) {
          // it exist
          promises.push(
            prisma.attributeGroupLink.create({
              data: {
                attribute_id: atrribute.attribute_id,
                group_id: attributeData.groups[index],
              },
            })
          );
        }
      }
    }
    //
    const result = await Promise.allSettled(promises);
    res.status(200).json({
      result: result,
    });
    //
  } catch (error) {
    res.status(500).json({
      error: error,
    });
  }
};

module.exports = {
  createAttributeGroup,
  createAttribute,
  updateAttribute,
};
