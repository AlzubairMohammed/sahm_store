CREATE TABLE `users` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `email` varchar(25) NOT NULL,
    `phone` varchar(15) NOT NULL,
    `avatar_url` VARCHAR(255),
    `password` text NOT NULL,
    `role` varchar(25) NOT NULL,
    `is_verified` BOOLEAN DEFAULT false,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `shipping_addresses` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `city` varchar(25) NOT NULL,
    `country` varchar(25) NOT NULL,
    `state` varchar(25) NOT NULL,
    `adress` text NOT NULL,
    `zip` INT NOT NULL,
    `active` BOOLEAN DEFAULT false,
    `user_id` INT NOT NULL,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `promo_code` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `code` VARCHAR(50) UNIQUE NOT NULL,
    `description` VARCHAR(255),
    `discount_type` ENUM ('percentage', 'fixed_amount') NOT NULL,
    `dscount_value` DECIMAL(10,2) NOT NULL,
    `expiry_date` DATE NOT NULL,
    `usage_limit` INT,
    `created` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
    `updated` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `user_promo_code` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `promo_code_id` INT NOT NULL,
    `usage_date` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `categories` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `sub_categories` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `category_id` INT NOT NULL,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `order_items` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `quantity` INT NOT NULL,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `orders` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `payment_method` VARCHAR(50),
    `status` ENUM ('Cancelled', 'Processing', 'Shipped', 'Delivered'),
    `tracking_number` VARCHAR(255),
    `user_id` INT NOT NULL,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `transactions` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `order_id` INT,
    `payment_method_id` INT,
    `amount` DECIMAL(10,2),
    `currency` VARCHAR(3),
    `timestamp` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `invoices` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `order_id` INT,
    `amount` DECIMAL(10,2),
    `due_date` DATE,
    `status` ENUM ('Paid', 'Unpaid', 'Overdue'),
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `attributes` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `products` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `descr` varchar(255) NOT NULL,
    `product_type` varchar(255) NOT NULL,
    `buy_price` decimal(10,2) NOT NULL,
    `sale_price` decimal(10,2) NOT NULL,
    `sub_category_id` INT NOT NULL,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `product_attributes` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `product_id` INT NOT NULL,
    `attribute_id` INT NOT NULL,
    `image` varchar(255) NOT NULL,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `product_images` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `image` varchar(255) NOT NULL,
    `product_id` INT NOT NULL,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `product_variations` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `product_id` INT NOT NULL,
    `buy_price` decimal(10,2) NOT NULL,
    `sale_price` decimal(10,2) NOT NULL,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );

  CREATE TABLE `product_variations_images` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `image` varchar(255) NOT NULL,
    `product_variation_id` INT NOT NULL,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `attribute_options` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `option_id` INTEGER PRIMARY KEY,
    `attribute_id` INTEGER,
    `name` TEXT,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  CREATE TABLE `options` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` TEXT,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `variation_attributes` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `image` varchar(255) NOT NULL,
    `variation_id` INT NOT NULL,
    `attribute_id` INT NOT NULL,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `products_rate` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `rate` decimal(10,2) NOT NULL,
    `review` TEXT,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `cart` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT,
    `product_id` INT,
    `quantity` INT,
    `added_date` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `favorites` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT,
    `product_id` INT,
    `added_timestamp` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `facebook_auth` (
    `user_id` INT PRIMARY KEY,
    `facebook_id` VARCHAR(255) UNIQUE NOT NULL,
    `access_token` VARCHAR(1000),
    `token_expiry` TIMESTAMP,
    `refresh_token` VARCHAR(1000),
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `google_auth` (
    `user_id` INT PRIMARY KEY,
    `google_id` VARCHAR(255) UNIQUE NOT NULL,
    `access_token` VARCHAR(1000),
    `token_expiry` TIMESTAMP,
    `refresh_token` VARCHAR(1000),
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `payment_methods` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT,
    `card_number` varchar(25),
    `expire_date` DATE,
    `cvv` varchar(10),
    `payment_type` VARCHAR(50),
    `default` BOOLEAN,
    `created` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
    `updated` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE TABLE `notifications` (
    `id` INT PRIMARY KEY,
    `user_id` INTEGER,
    `notification_type` VARCHAR(50) NOT NULL,
    `message` TEXT NOT NULL,
    `is_read` BOOLEAN DEFAULT false,
    `created` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
    `updated` TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
  );
  
  CREATE INDEX `category_id` ON `sub_categories` (`category_id`);
  
  CREATE INDEX `user_id` ON `orders` (`user_id`);
  
  CREATE INDEX `sub_category_id` ON `products` (`sub_category_id`);
  
  CREATE INDEX `product_id` ON `product_attributes` (`product_id`);
  
  CREATE INDEX `attribute_id` ON `product_attributes` (`attribute_id`);
  
  CREATE INDEX `product_id` ON `product_images` (`product_id`);
  
  CREATE INDEX `product_id` ON `product_variations` (`product_id`);
  
  CREATE INDEX `variation_id` ON `variation_attributes` (`variation_id`);
  
  CREATE INDEX `attribute_id` ON `variation_attributes` (`attribute_id`);
  
  CREATE INDEX `user_id` ON `products_rate` (`user_id`);
  
  CREATE INDEX `product_id` ON `products_rate` (`product_id`);
  
  ALTER TABLE `notifications` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
  
  ALTER TABLE `shipping_addresses` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
  
  ALTER TABLE `user_promo_code` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
  
  ALTER TABLE `user_promo_code` ADD FOREIGN KEY (`promo_code_id`) REFERENCES `promo_code` (`id`);
  
  ALTER TABLE `transactions` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);
  
  ALTER TABLE `transactions` ADD FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`);
  
  ALTER TABLE `invoices` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);
  
  ALTER TABLE `attribute_options` ADD FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`);
  ALTER TABLE `attribute_options` ADD FOREIGN KEY (`option_id`) REFERENCES `options` (`id`);
  
  ALTER TABLE `cart` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
  
  ALTER TABLE `cart` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
  
  ALTER TABLE `favorites` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
  
  ALTER TABLE `favorites` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
  
  ALTER TABLE `facebook_auth` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
  
  ALTER TABLE `google_auth` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
  
  ALTER TABLE `payment_methods` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
  
  ALTER TABLE `orders` ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;
  
  ALTER TABLE `product_attributes` ADD CONSTRAINT `product_attributes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
  
  ALTER TABLE `product_attributes` ADD CONSTRAINT `product_attributes_ibfk_2` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON UPDATE CASCADE;
  
  ALTER TABLE `product_images` ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
  
  ALTER TABLE `product_variations` ADD CONSTRAINT `product_variations_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
  
  ALTER TABLE `products` ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`sub_category_id`) REFERENCES `sub_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
  
  ALTER TABLE `products_rate` ADD CONSTRAINT `products_rate_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;
  
  ALTER TABLE `products_rate` ADD CONSTRAINT `products_rate_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON UPDATE CASCADE;
  
  ALTER TABLE `sub_categories` ADD CONSTRAINT `sub_categories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
  
  ALTER TABLE `variation_attributes` ADD CONSTRAINT `variation_attributes_ibfk_1` FOREIGN KEY (`variation_id`) REFERENCES `product_variations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
  
  ALTER TABLE `variation_attributes` ADD CONSTRAINT `variation_attributes_ibfk_2` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON UPDATE CASCADE;
  