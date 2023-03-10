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
ALTER TABLE `product` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    MODIFY `manage_stock` INTEGER NOT NULL,
    MODIFY `stock_availability` INTEGER NOT NULL,
    MODIFY `status` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `variant_group` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));
