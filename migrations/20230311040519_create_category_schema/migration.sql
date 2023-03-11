/*
 Warnings:
 
 - A unique constraint covering the columns `[uuid]` on the table `product_attribute_value_index` will be added. If there are existing duplicate values, this will fail.
 - A unique constraint covering the columns `[product_id,attribute_id]` on the table `product_attribute_value_index` will be added. If there are existing duplicate values, this will fail.
 
 */
-- DropForeignKey
ALTER TABLE
    `product_attribute_value_index` DROP FOREIGN KEY `product_attribute_value_index_product_id_fkey`;

-- AlterTable
ALTER TABLE
    `attribute`
MODIFY
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', ''));

-- AlterTable
ALTER TABLE
    `attribute_group`
MODIFY
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', ''));

-- AlterTable
ALTER TABLE
    `attribute_option`
MODIFY
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', ''));

-- AlterTable
ALTER TABLE
    `customer`
MODIFY
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', ''));

-- AlterTable
ALTER TABLE
    `customer_address`
MODIFY
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', ''));

-- AlterTable
ALTER TABLE
    `customer_group`
MODIFY
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', ''));

-- AlterTable
ALTER TABLE
    `product`
MODIFY
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', ''));

-- AlterTable
-- ALTER TABLE `product_attribute_value_index` ADD COLUMN `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));
-- AlterTable
ALTER TABLE
    `variant_group`
MODIFY
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', ''));

-- CreateTable
CREATE TABLE `category` (
    `category_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', '')),
    `status` INTEGER NOT NULL,
    `parent_id` INTEGER NULL,
    `include_in_nav` INTEGER NOT NULL,
    `position` INTEGER NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    UNIQUE INDEX `category_uuid_key`(`uuid`),
    PRIMARY KEY (`category_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ProductCateogory` (
    `product_category_id` INTEGER NOT NULL AUTO_INCREMENT,
    `category_id` INTEGER NOT NULL,
    `product_id` INTEGER NOT NULL,
    UNIQUE INDEX `ProductCateogory_category_id_product_id_key`(`category_id`, `product_id`),
    PRIMARY KEY (`product_category_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CategoryDescription` (
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
    UNIQUE INDEX `CategoryDescription_category_description_category_id_key`(`category_description_category_id`),
    PRIMARY KEY (`category_description_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
-- CREATE UNIQUE INDEX `product_attribute_value_index_uuid_key` ON `product_attribute_value_index`(`uuid`);

-- CreateIndex
CREATE UNIQUE INDEX `product_attribute_value_index_product_id_attribute_id_key` ON `product_attribute_value_index`(`product_id`, `attribute_id`);

-- AddForeignKey
ALTER TABLE
    `product_attribute_value_index`
ADD
    CONSTRAINT `product_attribute_value_index_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE
    `ProductCateogory`
ADD
    CONSTRAINT `ProductCateogory_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `category`(`category_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE
    `ProductCateogory`
ADD
    CONSTRAINT `ProductCateogory_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE
    `CategoryDescription`
ADD
    CONSTRAINT `CategoryDescription_category_description_category_id_fkey` FOREIGN KEY (`category_description_category_id`) REFERENCES `category`(`category_id`) ON DELETE CASCADE ON UPDATE CASCADE;