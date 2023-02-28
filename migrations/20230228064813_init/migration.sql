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
    `updated_at` DATETIME(3) NOT NULL,

    UNIQUE INDEX `customer_uuid_key`(`uuid`),
    UNIQUE INDEX `customer_email_key`(`email`),
    PRIMARY KEY (`customer_id`)
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
    `updated_at` DATETIME(3) NOT NULL,
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
    `updated_at` DATETIME(3) NOT NULL,
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
    `updated_at` DATETIME(3) NOT NULL,

    UNIQUE INDEX `user_token_secret_user_id_key`(`user_id`),
    PRIMARY KEY (`user_token_secret_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `customer` ADD CONSTRAINT `customer_group_id_fkey` FOREIGN KEY (`group_id`) REFERENCES `customer_group`(`customer_group_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `customer_address` ADD CONSTRAINT `customer_address_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
