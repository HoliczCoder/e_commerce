/*
  Warnings:

  - A unique constraint covering the columns `[user_id,sid]` on the table `user_token_secret` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX `user_token_secret_user_id_key` ON `user_token_secret`;

-- AlterTable
ALTER TABLE `admin_user` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `attribute` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `attribute_group` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `attribute_option` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `cart` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `cart_address` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `cart_item` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `category` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `customer` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `customer_address` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `customer_group` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `order` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `order_address` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `order_item` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `payment_transaction` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `product` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `product_attribute_value_index` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `shipment` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `variant_group` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- CreateIndex
CREATE UNIQUE INDEX `user_token_secret_user_id_sid_key` ON `user_token_secret`(`user_id`, `sid`);
