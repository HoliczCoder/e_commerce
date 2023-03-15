-- AlterTable
ALTER TABLE `admin_user` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `attribute` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `attribute_group` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `attribute_option` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `cart` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    MODIFY `currency` VARCHAR(191) NOT NULL DEFAULT 'USD',
    MODIFY `shipping_fee_excl_tax` DOUBLE NULL DEFAULT 0.0000,
    MODIFY `shipping_fee_incl_tax` DOUBLE NULL DEFAULT 0.0000,
    MODIFY `discount_amount` DOUBLE NULL DEFAULT 0.0000,
    MODIFY `tax_amount` DOUBLE NOT NULL DEFAULT 0.0000,
    MODIFY `shipping_method` VARCHAR(191) NULL,
    MODIFY `shipping_method_name` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `cart_address` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `cart_item` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    MODIFY `thumbnail` VARCHAR(191) NULL;

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
ALTER TABLE `product` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    MODIFY `image` VARCHAR(191) NULL;

-- AlterTable
ALTER TABLE `product_attribute_value_index` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `shipment` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));

-- AlterTable
ALTER TABLE `variant_group` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-',''));
