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

-- CreateTable
CREATE TABLE `product` (
    `product_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', '')),
    `variant_group_id` INTEGER NULL,
    `visibility` INTEGER NOT NULL DEFAULT 1,
    `group_id` INTEGER NULL,
    `image` INTEGER NULL,
    `sku` VARCHAR(191) NOT NULL,
    `price` DOUBLE NOT NULL,
    `qty` INTEGER NOT NULL,
    `weight` DOUBLE NULL,
    `manage_stock` BOOLEAN NOT NULL,
    `stock_availability` BOOLEAN NOT NULL,
    `tax_class` INTEGER NULL,
    `status` BOOLEAN NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    UNIQUE INDEX `product_uuid_key`(`uuid`),
    UNIQUE INDEX `product_sku_key`(`sku`),
    PRIMARY KEY (`product_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `variant_group` (
    `variant_group_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', '')),
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
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', '')),
    `group_name` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    UNIQUE INDEX `attribute_group_uuid_key`(`uuid`),
    PRIMARY KEY (`attribute_group_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `attribute` (
    `attribute_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', '')),
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
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', '')),
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
    -- modify adding uuid here
    `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(), '-', '')),
    `product_id` INTEGER NOT NULL,
    `attribute_id` INTEGER NOT NULL,
    `option_id` INTEGER NULL,
    `option_text` VARCHAR(191) NULL,
    UNIQUE INDEX `product_attribute_value_index_product_id_attribute_id_option_key`(`product_id`, `attribute_id`, `option_id`),
    PRIMARY KEY (`product_attribute_value_index_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE
    `product`
ADD
    CONSTRAINT `product_variant_group_id_fkey` FOREIGN KEY (`variant_group_id`) REFERENCES `variant_group`(`variant_group_id`) ON DELETE
SET
    NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE
    `product`
ADD
    CONSTRAINT `product_group_id_fkey` FOREIGN KEY (`group_id`) REFERENCES `attribute_group`(`attribute_group_id`) ON DELETE
SET
    NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE
    `variant_group`
ADD
    CONSTRAINT `variant_group_attribute_group_id_fkey` FOREIGN KEY (`attribute_group_id`) REFERENCES `attribute_group`(`attribute_group_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE
    `variant_group`
ADD
    CONSTRAINT `variant_group_attribute_one_fkey` FOREIGN KEY (`attribute_one`) REFERENCES `attribute`(`attribute_id`) ON DELETE
SET
    NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE
    `attribute_group_link`
ADD
    CONSTRAINT `attribute_group_link_attribute_id_fkey` FOREIGN KEY (`attribute_id`) REFERENCES `attribute`(`attribute_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE
    `attribute_group_link`
ADD
    CONSTRAINT `attribute_group_link_group_id_fkey` FOREIGN KEY (`group_id`) REFERENCES `attribute_group`(`attribute_group_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE
    `attribute_option`
ADD
    CONSTRAINT `attribute_option_attribute_id_fkey` FOREIGN KEY (`attribute_id`) REFERENCES `attribute`(`attribute_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE
    `product_attribute_value_index`
ADD
    CONSTRAINT `product_attribute_value_index_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE
    `product_attribute_value_index`
ADD
    CONSTRAINT `product_attribute_value_index_attribute_id_fkey` FOREIGN KEY (`attribute_id`) REFERENCES `attribute`(`attribute_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE
    `product_attribute_value_index`
ADD
    CONSTRAINT `product_attribute_value_index_option_id_fkey` FOREIGN KEY (`option_id`) REFERENCES `attribute_option`(`attribute_option_id`) ON DELETE
SET
    NULL ON UPDATE CASCADE;