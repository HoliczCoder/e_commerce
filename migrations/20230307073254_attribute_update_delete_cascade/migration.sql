-- DropForeignKey
ALTER TABLE `attribute_group_link` DROP FOREIGN KEY `attribute_group_link_attribute_id_fkey`;

-- DropForeignKey
ALTER TABLE `attribute_option` DROP FOREIGN KEY `attribute_option_attribute_id_fkey`;

-- DropForeignKey
ALTER TABLE `product_attribute_value_index` DROP FOREIGN KEY `product_attribute_value_index_attribute_id_fkey`;

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

-- AddForeignKey
ALTER TABLE `attribute_group_link` ADD CONSTRAINT `attribute_group_link_attribute_id_fkey` FOREIGN KEY (`attribute_id`) REFERENCES `attribute`(`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `attribute_option` ADD CONSTRAINT `attribute_option_attribute_id_fkey` FOREIGN KEY (`attribute_id`) REFERENCES `attribute`(`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_attribute_value_index` ADD CONSTRAINT `product_attribute_value_index_attribute_id_fkey` FOREIGN KEY (`attribute_id`) REFERENCES `attribute`(`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE;
