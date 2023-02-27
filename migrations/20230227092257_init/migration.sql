-- AlterTable
ALTER TABLE `customer` MODIFY `group_id` INTEGER NULL;

-- CreateTable
CREATE TABLE `customer_group` (
    `customer_group_id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(191) NOT NULL,
    `group_name` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `row_id` INTEGER NOT NULL,

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

    UNIQUE INDEX `user_token_secret_user_id_key`(`user_id`),
    PRIMARY KEY (`user_token_secret_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `customer` ADD CONSTRAINT `customer_group_id_fkey` FOREIGN KEY (`group_id`) REFERENCES `customer_group`(`customer_group_id`) ON DELETE SET NULL ON UPDATE CASCADE;
