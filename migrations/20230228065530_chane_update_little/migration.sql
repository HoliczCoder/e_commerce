-- AlterTable
ALTER TABLE `customer` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    MODIFY `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);

-- AlterTable
ALTER TABLE `customer_address` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    MODIFY `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);

-- AlterTable
ALTER TABLE `customer_group` MODIFY `uuid` VARCHAR(191) NOT NULL DEFAULT (replace(uuid(),'-','')),
    MODIFY `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);

-- AlterTable
ALTER TABLE `user_token_secret` MODIFY `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);
