const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const _ = require("lodash");
const {
  createNewAttributeGroup,
  createNewAttributeOption,
} = require("../service/attribute.service");

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
    //
    // const attributeGroupResult = "";
    // const attributeOptionResult = "";
    if (attributeData.groups.length) {
      await createNewAttributeGroup(
        attributeData.groups,
        atrribute.attribute_id
      );
    }
    if (attributeData.options.length) {
      await createNewAttributeOption(
        attributeData.options,
        atrribute.attribute_id,
        atrribute.attribute_code
      );
    }
    res.status(200).json({
      result: {
        atrribute,
      },
    });
    //
  } catch (error) {
    res.status(500).json({
      error: error,
    });
  }
};



const deleteAttribute = async (req, res) => {
  const atrributeUUID = req.body.uuid;
  try {
    const ifExistAttribute = await prisma.atrribute.findUnique({
      where: {
        uuid: atrributeUUID,
      },
    });
    if (!ifExistAttribute) {
      res.status(400).json({
        error: "attribute not exist",
      });
      return;
    }
    const deleteAttribute = await prisma.atrribute.delete({
      where: {
        uuid: atrributeUUID,
      },
    });
    res.status(200).json({
      res: deleteAttribute,
    });
  } catch (error) {
    res.status(500).json({
      error: error,
    });
  }
};

const deleteAttributeGroup = async (req, res) => {
  const attributeGroupUUID = req.body.uuid;
  try {
    const deleteAttributeGroupUUID = await prisma.atrributeGroup.delete({
      where: {
        uuid: attributeGroupUUID,
      },
    });
    res.status(200).json({
      res: deleteAttributeGroupUUID,
    });
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
    // update attribute group
    if (attributeData.groups.length) {
      const attribute_group_link = await prisma.attributeGroupLink.findMany({
        where: {
          attribute_id: attributeData.attribute_id,
        },
      });
      //
      if (!attribute_group_link.length) {
        // have to create new
        await createNewAttributeGroup(
          attributeData.groups,
          atrribute.attribute_id
        );
        //
      } else {
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
        for (let index = 0; index < attributeData.groups.length; index += 1) {
          // find if group id is inside attribute_group_link group id
          const result = _.find(attribute_group_link, {
            group_id: attributeData.groups[index],
          });
          if (!result) {
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
        await Promise.allSettled(promises);
        //
      }
    }
    // update attribute options
    if (attributeData.options.length) {
      const attribute_options = await prisma.attributeOption.findMany({
        where: {
          attribute_id: attributeData.attribute_id,
        },
      });
      if (!attribute_options.length) {
        // have to create new
        await createNewAttributeOption(
          attributeData.options,
          atrribute.attribute_id,
          atrribute.attribute_code
        );
        //
      } else {
        // if attribute_option exist
        const promises = [];
        attribute_options.map(async (item) => {
          // this group id had been removed
          if (
            !_.find(attributeData.options, {
              option_id: item.attribute_option_id,
            })
          ) {
            // remove it from db
            promises.push(
              prisma.attributeOption.delete({
                where: {
                  attribute_option_id: item.attribute_option_id,
                },
              })
            );
          }
        });
        // check if attributeData.options have extra options
        for (let index = 0; index < attributeData.options.length; index += 1) {
          // find if attribute id is inside attribute_attribute attribute id
          const result = _.find(attribute_options, {
            attribute_option_id: attributeData.options[index].option_id,
          });
          if (!result) {
            promises.push(
              prisma.attributeOption.create({
                data: {
                  attribute_id: atrribute.attribute_id,
                  attribute_code: atrribute.attribute_code,
                  option_text: attributeData.options[index].option_text,
                },
              })
            );
          }
        }
        //
        await Promise.allSettled(promises);
        //
      }
    }

    //
    res.status(200).json({
      result: atrribute,
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
  deleteAttribute,
  deleteAttributeGroup,
};
