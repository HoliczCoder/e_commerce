-- CreateTable
CREATE TABLE `customer` (
    `customer_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `status` INTEGER NOT NULL DEFAULT 1,
    `group_id` INTEGER NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `full_name` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `customer_uuid_key`(`uuid`),
    UNIQUE INDEX `customer_email_key`(`email`),
    PRIMARY KEY (`customer_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

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
CREATE TABLE `customer_address` (
    `customer_address_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `customer_id` INTEGER NOT NULL,
    `full_name` VARCHAR(191) NULL,
    `telephone` VARCHAR(191) NULL,
    `address_1` VARCHAR(191) NULL,
    `address_2` VARCHAR(191) NULL,
    `postcode` VARCHAR(191) NULL,
    `city` VARCHAR(191) NULL,
    `province` VARCHAR(191) NULL,
    `country` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `is_default` INTEGER NULL,

    UNIQUE INDEX `customer_address_uuid_key`(`uuid`),
    UNIQUE INDEX `customer_address_customer_id_key`(`customer_id`),
    INDEX `FK_CUSTOMER_ADDRESS_LINK`(`customer_id`),
    PRIMARY KEY (`customer_address_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customer_group` (
    `customer_group_id` INTEGER NOT NULL,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `group_name` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `row_id` INTEGER NOT NULL AUTO_INCREMENT,

    UNIQUE INDEX `customer_group_customer_group_id_key`(`customer_group_id`),
    UNIQUE INDEX `customer_group_uuid_key`(`uuid`),
    UNIQUE INDEX `customer_group_row_id_key`(`row_id`),
    INDEX `customer_group_row_id_idx`(`row_id`),
    PRIMARY KEY (`customer_group_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_token_secret` (
    `user_token_secret_id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` VARCHAR(191) NOT NULL,
    `sid` VARCHAR(191) NOT NULL,
    `secret` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`user_token_secret_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product` (
    `product_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `variant_group_id` INTEGER NULL,
    `visibility` INTEGER NOT NULL DEFAULT 1,
    `group_id` INTEGER NULL,
    `image` VARCHAR(191) NULL,
    `sku` VARCHAR(191) NOT NULL,
    `price` DOUBLE NOT NULL,
    `qty` INTEGER NOT NULL,
    `weight` DOUBLE NULL,
    `manage_stock` INTEGER NOT NULL,
    `stock_availability` INTEGER NOT NULL,
    `tax_class` INTEGER NULL,
    `status` INTEGER NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `product_uuid_key`(`uuid`),
    UNIQUE INDEX `product_sku_key`(`sku`),
    PRIMARY KEY (`product_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_description` (
    `product_description_id` INTEGER NOT NULL AUTO_INCREMENT,
    `product_description_product_id` INTEGER NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `short_description` VARCHAR(191) NULL,
    `url_key` VARCHAR(191) NOT NULL,
    `meta_title` VARCHAR(191) NULL,
    `meta_description` VARCHAR(191) NULL,
    `meta_keywords` VARCHAR(191) NULL,

    UNIQUE INDEX `product_description_product_description_product_id_key`(`product_description_product_id`),
    PRIMARY KEY (`product_description_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `variant_group` (
    `variant_group_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `attribute_group_id` INTEGER NOT NULL,
    `attribute_one` INTEGER NULL,
    `attribute_two` INTEGER NULL,
    `attribute_three` INTEGER NULL,
    `attribute_four` INTEGER NULL,
    `attribute_five` INTEGER NULL,
    `visibility` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `variant_group_uuid_key`(`uuid`),
    PRIMARY KEY (`variant_group_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attribute_group` (
    `attribute_group_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `group_name` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `attribute_group_uuid_key`(`uuid`),
    PRIMARY KEY (`attribute_group_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attribute` (
    `attribute_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `attribute_code` VARCHAR(191) NOT NULL,
    `attribute_name` VARCHAR(191) NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `is_required` INTEGER NOT NULL DEFAULT 0,
    `display_on_frontend` INTEGER NOT NULL DEFAULT 0,
    `sort_order` INTEGER NOT NULL DEFAULT 0,
    `is_filterable` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `attribute_uuid_key`(`uuid`),
    UNIQUE INDEX `attribute_attribute_code_key`(`attribute_code`),
    PRIMARY KEY (`attribute_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attribute_group_link` (
    `attribute_group_link_id` INTEGER NOT NULL AUTO_INCREMENT,
    `attribute_id` INTEGER NOT NULL,
    `group_id` INTEGER NOT NULL,

    PRIMARY KEY (`attribute_group_link_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attribute_option` (
    `attribute_option_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `attribute_id` INTEGER NOT NULL,
    `attribute_code` VARCHAR(191) NOT NULL,
    `option_text` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `attribute_option_uuid_key`(`uuid`),
    INDEX `attribute_option_attribute_id_idx`(`attribute_id`),
    PRIMARY KEY (`attribute_option_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `product_attribute_value_index` (
    `product_attribute_value_index_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `product_id` INTEGER NOT NULL,
    `attribute_id` INTEGER NOT NULL,
    `option_id` INTEGER NULL,
    `option_text` VARCHAR(191) NULL,

    UNIQUE INDEX `product_attribute_value_index_uuid_key`(`uuid`),
    UNIQUE INDEX `product_attribute_value_index_product_id_attribute_id_option_key`(`product_id`, `attribute_id`, `option_id`),
    UNIQUE INDEX `product_attribute_value_index_product_id_attribute_id_key`(`product_id`, `attribute_id`),
    PRIMARY KEY (`product_attribute_value_index_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `category` (
    `category_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
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

-- CreateTable
CREATE TABLE `cart` (
    `cart_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    `sid` VARCHAR(191) NULL,
    `currency` VARCHAR(191) NOT NULL DEFAULT 'USD',
    `customer_id` INTEGER NULL,
    `customer_group_id` INTEGER NULL,
    `customer_email` VARCHAR(191) NULL,
    `customer_full_name` VARCHAR(191) NULL,
    `user_ip` VARCHAR(191) NULL,
    `status` INTEGER NOT NULL DEFAULT 0,
    `coupon` INTEGER NULL,
    `shipping_fee_excl_tax` DOUBLE NULL DEFAULT 0.0000,
    `shipping_fee_incl_tax` DOUBLE NULL DEFAULT 0.0000,
    `discount_amount` DOUBLE NULL DEFAULT 0.0000,
    `sub_total` DOUBLE NOT NULL DEFAULT 0.0000,
    `total_qty` INTEGER NOT NULL DEFAULT 0,
    `total_weight` DOUBLE NULL,
    `tax_amount` DOUBLE NOT NULL DEFAULT 0.0000,
    `grand_total` DOUBLE NULL,
    `shipping_method` VARCHAR(191) NULL,
    `shipping_method_name` VARCHAR(191) NULL,
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
    `thumbnail` VARCHAR(191) NULL,
    `product_weigth` DOUBLE NULL,
    `product_price` DOUBLE NOT NULL,
    `product_price_incl_tax` DOUBLE NOT NULL,
    `qty` INTEGER NOT NULL,
    `final_price` DOUBLE NOT NULL,
    `final_price_incl_tax` DOUBLE NOT NULL,
    `tax_percent` DOUBLE NOT NULL DEFAULT 0.0000,
    `tax_amount` DOUBLE NOT NULL DEFAULT 0.0000,
    `discount_amount` DOUBLE NOT NULL DEFAULT 0.0000,
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
ALTER TABLE `customer` ADD CONSTRAINT `customer_group_id_fkey` FOREIGN KEY (`group_id`) REFERENCES `customer_group`(`customer_group_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `customer_address` ADD CONSTRAINT `customer_address_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product` ADD CONSTRAINT `product_variant_group_id_fkey` FOREIGN KEY (`variant_group_id`) REFERENCES `variant_group`(`variant_group_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product` ADD CONSTRAINT `product_group_id_fkey` FOREIGN KEY (`group_id`) REFERENCES `attribute_group`(`attribute_group_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_description` ADD CONSTRAINT `product_description_product_description_product_id_fkey` FOREIGN KEY (`product_description_product_id`) REFERENCES `product`(`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `variant_group` ADD CONSTRAINT `variant_group_attribute_group_id_fkey` FOREIGN KEY (`attribute_group_id`) REFERENCES `attribute_group`(`attribute_group_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `variant_group` ADD CONSTRAINT `variant_group_attribute_one_fkey` FOREIGN KEY (`attribute_one`) REFERENCES `attribute`(`attribute_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `attribute_group_link` ADD CONSTRAINT `attribute_group_link_attribute_id_fkey` FOREIGN KEY (`attribute_id`) REFERENCES `attribute`(`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `attribute_group_link` ADD CONSTRAINT `attribute_group_link_group_id_fkey` FOREIGN KEY (`group_id`) REFERENCES `attribute_group`(`attribute_group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `attribute_option` ADD CONSTRAINT `attribute_option_attribute_id_fkey` FOREIGN KEY (`attribute_id`) REFERENCES `attribute`(`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_attribute_value_index` ADD CONSTRAINT `product_attribute_value_index_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_attribute_value_index` ADD CONSTRAINT `product_attribute_value_index_attribute_id_fkey` FOREIGN KEY (`attribute_id`) REFERENCES `attribute`(`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_attribute_value_index` ADD CONSTRAINT `product_attribute_value_index_option_id_fkey` FOREIGN KEY (`option_id`) REFERENCES `attribute_option`(`attribute_option_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_cateogory` ADD CONSTRAINT `product_cateogory_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `category`(`category_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `product_cateogory` ADD CONSTRAINT `product_cateogory_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `category_description` ADD CONSTRAINT `category_description_category_description_category_id_fkey` FOREIGN KEY (`category_description_category_id`) REFERENCES `category`(`category_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
