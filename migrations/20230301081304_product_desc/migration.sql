-- AlterTable
ALTER TABLE `attribute` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `attribute_group` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `attribute_option` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `customer` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `customer_address` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `customer_group` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `product` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `variant_group` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- CreateTable
CREATE TABLE `ProductDescription` (
    `product_description_id` INTEGER NOT NULL AUTO_INCREMENT,
    `product_description_product_id` INTEGER NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `short_description` VARCHAR(191) NULL,
    `url_key` VARCHAR(191) NOT NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_description` VARCHAR(191) NULL,
    `meta_keywords` VARCHAR(191) NULL,

    UNIQUE INDEX `ProductDescription_product_description_product_id_key`(`product_description_product_id`),
    PRIMARY KEY (`product_description_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `ProductDescription` ADD CONSTRAINT `ProductDescription_product_description_product_id_fkey` FOREIGN KEY (`product_description_product_id`) REFERENCES `product`(`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
