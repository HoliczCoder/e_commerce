const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const _ = require("lodash");

const createNewAttributeGroup = async (groups, attribute_id) => {
  const promises = [];
  //
  for (let index = 0; index < groups.length; index += 1) {
    const group = await prisma.atrributeGroup.findUnique({
      where: {
        attribute_group_id: groups[index],
      },
    });
    if (group) {
      promises.push(
        prisma.attributeGroupLink.create({
          data: {
            attribute_id: attribute_id,
            group_id: groups[index],
          },
        })
      );
    }
  }
  //
  return await Promise.allSettled(promises);
};

const createNewAttributeOption = async (
  options,
  attribute_id,
  attribute_code
) => {
  const promises = [];
  for (const option of options) {
    promises.push(
      prisma.attributeOption.create({
        data: {
          attribute_id: attribute_id,
          attribute_code: attribute_code,
          option_text: option.option_text,
        },
      })
    );
  }
  return await Promise.allSettled(promises);
};

module.exports = {
  createNewAttributeGroup,
  createNewAttributeOption,
};
