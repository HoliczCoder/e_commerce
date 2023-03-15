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

-- CreateTable
CREATE TABLE `admin_user` (
    `admin_user_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `status` INTEGER NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `full_name` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `admin_user_uuid_key`(`uuid`),
    PRIMARY KEY (`admin_user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cart` (
    `cart_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `sid` VARCHAR(191) NULL,
    `currency` VARCHAR(191) NOT NULL,
    `customer_id` INTEGER NULL,
    `customer_group_id` INTEGER NULL,
    `customer_email` VARCHAR(191) NULL,
    `customer_full_name` VARCHAR(191) NULL,
    `user_ip` VARCHAR(191) NULL,
    `status` INTEGER NOT NULL,
    `coupon` INTEGER NULL,
    `shipping_fee_excl_tax` DOUBLE NULL,
    `shipping_fee_incl_tax` DOUBLE NULL,
    `discount_amount` DOUBLE NULL,
    `sub_total` DOUBLE NOT NULL,
    `total_qty` INTEGER NOT NULL,
    `total_weight` DOUBLE NULL,
    `tax_amount` DOUBLE NOT NULL,
    `grand_total` DOUBLE NULL,
    `shipping_method` VARCHAR(191) NOT NULL,
    `shipping_method_name` VARCHAR(191) NOT NULL,
    `shipping_address_id` INTEGER NULL,
    `billing_address_id` INTEGER NULL,
    `shipping_note` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `cart_uuid_key`(`uuid`),
    PRIMARY KEY (`cart_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cart_address` (
    `cart_address_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `full_name` VARCHAR(191) NULL,
    `postcode` VARCHAR(191) NULL,
    `telephone` VARCHAR(191) NULL,
    `country` VARCHAR(191) NULL,
    `province` VARCHAR(191) NULL,
    `city` VARCHAR(191) NULL,
    `address_1` VARCHAR(191) NULL,
    `address_2` VARCHAR(191) NULL,

    UNIQUE INDEX `cart_address_uuid_key`(`uuid`),
    PRIMARY KEY (`cart_address_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `cart_item` (
    `cart_item_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `cart_id` INTEGER NOT NULL,
    `product_id` INTEGER NOT NULL,
    `product_sku` VARCHAR(191) NOT NULL,
    `product_name` VARCHAR(191) NOT NULL,
    `thumbnail` VARCHAR(191) NOT NULL,
    `product_weigth` DOUBLE NULL,
    `product_price` DOUBLE NOT NULL,
    `product_price_incl_tax` DOUBLE NOT NULL,
    `qty` INTEGER NOT NULL,
    `final_price` DOUBLE NOT NULL,
    `final_price_incl_tax` DOUBLE NOT NULL,
    `tax_percent` DOUBLE NOT NULL,
    `tax_amount` DOUBLE NOT NULL,
    `discount_amount` DOUBLE NOT NULL,
    `total` DOUBLE NOT NULL,
    `variant_group_id` INTEGER NULL,
    `variant_options` VARCHAR(191) NULL,
    `product_custom_options` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `cart_item_uuid_key`(`uuid`),
    PRIMARY KEY (`cart_item_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `order` (
    `order_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `sid` VARCHAR(191) NULL,
    `order_number` VARCHAR(191) NOT NULL,
    `cart_id` INTEGER NOT NULL,
    `currency` VARCHAR(191) NOT NULL,
    `customer_id` INTEGER NOT NULL,
    `customer_email` VARCHAR(191) NULL,
    `customer_full_name` VARCHAR(191) NULL,
    `user_ip` VARCHAR(191) NULL,
    `user_agent` VARCHAR(191) NULL,
    `coupon` VARCHAR(191) NULL,
    `shipping_fee_excl_tax` DOUBLE NULL,
    `shipping_fee_incl_tax` DOUBLE NULL,
    `discount_amount` DOUBLE NULL,
    `sub_total` DOUBLE NOT NULL,
    `total_qty` INTEGER NOT NULL,
    `total_weight` DOUBLE NULL,
    `tax_amount` DOUBLE NOT NULL,
    `shipping_note` VARCHAR(191) NULL,
    `grand_total` DOUBLE NOT NULL,
    `shipping_method` VARCHAR(191) NULL,
    `shipping_method_name` VARCHAR(191) NULL,
    `shipping_address_id` INTEGER NULL,
    `payment_method` VARCHAR(191) NULL,
    `payment_method_name` VARCHAR(191) NULL,
    `billing_address_id` INTEGER NULL,
    `shipment_status` INTEGER NOT NULL DEFAULT 0,
    `payment_status` INTEGER NOT NULL DEFAULT 0,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `order_uuid_key`(`uuid`),
    UNIQUE INDEX `order_order_number_key`(`order_number`),
    UNIQUE INDEX `order_cart_id_key`(`cart_id`),
    PRIMARY KEY (`order_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `order_activity` (
    `order_activity_id` INTEGER NOT NULL AUTO_INCREMENT,
    `order_activity_order_id` INTEGER NOT NULL,
    `comment` VARCHAR(191) NOT NULL,
    `customer_notified` INTEGER NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `order_activity_order_activity_order_id_key`(`order_activity_order_id`),
    PRIMARY KEY (`order_activity_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `order_address` (
    `order_address_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `full_name` VARCHAR(191) NULL,
    `postcode` VARCHAR(191) NULL,
    `telephone` VARCHAR(191) NULL,
    `country` VARCHAR(191) NULL,
    `province` VARCHAR(191) NULL,
    `city` VARCHAR(191) NULL,
    `address_1` VARCHAR(191) NULL,
    `address_2` VARCHAR(191) NULL,

    UNIQUE INDEX `order_address_uuid_key`(`uuid`),
    PRIMARY KEY (`order_address_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `order_item` (
    `order_item_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `order_item_order_id` INTEGER NOT NULL,
    `product_id` INTEGER NOT NULL,
    `referer` INTEGER NULL,
    `product_sku` VARCHAR(191) NOT NULL,
    `product_name` VARCHAR(191) NOT NULL,
    `thumbnail` VARCHAR(191) NULL,
    `product_weight` DOUBLE NULL,
    `product_price` DOUBLE NOT NULL,
    `product_price_incl_tax` DOUBLE NOT NULL,
    `qty` INTEGER NOT NULL,
    `final_price` DOUBLE NOT NULL,
    `final_price_incl_tax` DOUBLE NOT NULL,
    `tax_percent` DOUBLE NOT NULL,
    `tax_amount` DOUBLE NOT NULL,
    `discount_amount` DOUBLE NOT NULL,
    `total` DOUBLE NOT NULL,
    `variant_group_id` INTEGER NULL,
    `variant_options` VARCHAR(191) NULL,
    `product_custom_options` VARCHAR(191) NULL,
    `requested_data` VARCHAR(191) NULL,

    UNIQUE INDEX `order_item_uuid_key`(`uuid`),
    PRIMARY KEY (`order_item_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `shipment` (
    `shipment_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `shipment_order_id` INTEGER NOT NULL,
    `carrier_name` VARCHAR(191) NULL,
    `tracking_number` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `shipment_uuid_key`(`uuid`),
    UNIQUE INDEX `shipment_shipment_order_id_key`(`shipment_order_id`),
    PRIMARY KEY (`shipment_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payment_transaction` (
    `payment_transaction_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `payment_transaction_order_id` INTEGER NOT NULL,
    `transaction_id` VARCHAR(191) NULL,
    `transaction_type` VARCHAR(191) NOT NULL,
    `amount` DOUBLE NOT NULL,
    `parent_transaction_id` VARCHAR(191) NULL,
    `payment_action` VARCHAR(191) NULL,
    `additional_information` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `payment_transaction_uuid_key`(`uuid`),
    UNIQUE INDEX `payment_transaction_payment_transaction_order_id_key`(`payment_transaction_order_id`),
    UNIQUE INDEX `payment_transaction_transaction_id_key`(`transaction_id`),
    PRIMARY KEY (`payment_transaction_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `cart_item` ADD CONSTRAINT `cart_item_cart_id_fkey` FOREIGN KEY (`cart_id`) REFERENCES `cart`(`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `cart_item` ADD CONSTRAINT `cart_item_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `order` ADD CONSTRAINT `order_cart_id_fkey` FOREIGN KEY (`cart_id`) REFERENCES `cart`(`cart_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `order` ADD CONSTRAINT `order_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `order_activity` ADD CONSTRAINT `order_activity_order_activity_id_fkey` FOREIGN KEY (`order_activity_id`) REFERENCES `order`(`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `order_item` ADD CONSTRAINT `order_item_order_item_order_id_fkey` FOREIGN KEY (`order_item_order_id`) REFERENCES `order`(`order_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `order_item` ADD CONSTRAINT `order_item_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `shipment` ADD CONSTRAINT `shipment_shipment_order_id_fkey` FOREIGN KEY (`shipment_order_id`) REFERENCES `order`(`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `payment_transaction` ADD CONSTRAINT `payment_transaction_payment_transaction_order_id_fkey` FOREIGN KEY (`payment_transaction_order_id`) REFERENCES `order`(`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;
