-- CreateTable
CREATE TABLE `customer` (
    `customer_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL,
    `status` INTEGER NOT NULL,
    `group_id` INTEGER NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `full_name` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `customer_email_key`(`email`),
    PRIMARY KEY (`customer_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `customer_address` (
    `customer_address_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL,
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

    UNIQUE INDEX `customer_address_customer_id_key`(`customer_id`),
    PRIMARY KEY (`customer_address_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `customer_address` ADD CONSTRAINT `customer_address_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
