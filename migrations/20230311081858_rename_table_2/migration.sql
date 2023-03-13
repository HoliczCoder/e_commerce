/*
  Warnings:

  - You are about to drop the `categorydescription` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `productcateogory` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `categorydescription` DROP FOREIGN KEY `CategoryDescription_category_description_category_id_fkey`;

-- DropForeignKey
ALTER TABLE `productcateogory` DROP FOREIGN KEY `ProductCateogory_category_id_fkey`;

-- DropForeignKey
ALTER TABLE `productcateogory` DROP FOREIGN KEY `ProductCateogory_product_id_fkey`;

-- AlterTable
ALTER TABLE `attribute` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `attribute_group` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `attribute_option` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `category` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `customer` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `customer_address` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `customer_group` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `product` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `product_attribute_value_index` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `variant_group` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- DropTable
DROP TABLE `categorydescription`;

-- DropTable
DROP TABLE `productcateogory`;

-- CreateTable
CREATE TABLE `product_cateogory` (
    `product_category_id` INTEGER NOT NULL AUTO_INCREMENT,
    `category_id` INTEGER NOT NULL,
    `product_id` INTEGER NOT NULL,

    UNIQUE INDEX `product_cateogory_category_id_product_id_key`(`category_id`, `product_id`),
    PRIMARY KEY (`product_category_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `category_description` (
    `category_description_id` INTEGER NOT NULL AUTO_INCREMENT,
    `category_description_category_id` INTEGER NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `short_description` VARCHAR(191) NULL,
    `description` VARCHAR(191) NULL,
    `image` VARCHAR(191) NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_keywords` VARCHAR(191) NULL,
    `meta_description` VARCHAR(191) NULL,
    `url_key` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `category_description_category_description_category_id_key`(`category_description_category_id`),
    PRIMARY KEY (`category_description_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `product_cateogory` ADD CONSTRAINT `product_cateogory_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `category`(`category_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_cateogory` ADD CONSTRAINT `product_cateogory_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `category_description` ADD CONSTRAINT `category_description_category_description_category_id_fkey` FOREIGN KEY (`category_description_category_id`) REFERENCES `category`(`category_id`) ON DELETE CASCADE ON UPDATE CASCADE;
