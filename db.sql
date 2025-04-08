CREATE DATABASE recipe_website;
USE recipe_website;

-- Users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_admin BOOLEAN DEFAULT FALSE
);

-- Categories table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    image_url VARCHAR(255)
);

-- Recipes table
CREATE TABLE recipes (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    ingredients TEXT NOT NULL,
    preparation_steps TEXT NOT NULL,
    cooking_time INT NOT NULL, -- in minutes
    servings INT NOT NULL,
    category_id INT,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    image_url VARCHAR(255),
    calories INT,
    protein DECIMAL(5,1),
    carbs DECIMAL(5,1),
    fat DECIMAL(5,1),
    dietary_tags VARCHAR(255), -- comma-separated values like 'vegetarian,gluten-free'
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Reviews table
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Insert data into users table
INSERT INTO users (username, email, password_hash, is_admin) VALUES
('admin', 'admin@recipe.com', '$2y$10$HvZ1T0xW5X5O5Z9X0X0X0uJ0X0X0X0X0X0X0X0X0X0X0X0X0X0X0', TRUE),
('chef_john', 'john@email.com', '$2y$10$HvZ1T0xW5X5O5Z9X0X0X0uJ0X0X0X0X0X0X0X0X0X0X0X0X0X0X0', FALSE),
('baking_lover', 'sarah@email.com', '$2y$10$HvZ1T0xW5X5O5Z9X0X0X0uJ0X0X0X0X0X0X0X0X0X0X0X0X0X0X0', FALSE),
('healthy_eater', 'mike@email.com', '$2y$10$HvZ1T0xW5X5O5Z9X0X0X0uJ0X0X0X0X0X0X0X0X0X0X0X0X0X0X0', FALSE),
('spice_master', 'priya@email.com', '$2y$10$HvZ1T0xW5X5O5Z9X0X0X0uJ0X0X0X0X0X0X0X0X0X0X0X0X0X0X0', FALSE);

-- Insert data into categories table
INSERT INTO categories (name, description, image_url) VALUES
('Breakfast', 'Start your day right with these delicious breakfast recipes', 'breakfast.jpg'),
('Lunch', 'Quick and satisfying meals for midday', 'lunch.jpg'),
('Dinner', 'Hearty meals to end your day', 'dinner.jpg'),
('Desserts', 'Sweet treats for every occasion', 'desserts.jpg'),
('Vegetarian', 'Meat-free dishes full of flavor', 'vegetarian.jpg'),
('Vegan', 'Plant-based recipes without animal products', 'vegan.jpg'),
('Gluten-Free', 'Delicious recipes without gluten', 'glutenfree.jpg');

-- Insert data into recipes table
INSERT INTO recipes (title, description, ingredients, preparation_steps, cooking_time, servings, category_id, user_id, image_url, calories, protein, carbs, fat, dietary_tags) VALUES
('Classic Pancakes', 'Fluffy and delicious traditional pancakes', '2 cups flour, 2 tbsp sugar, 1 tbsp baking powder, 1/2 tsp salt, 1 3/4 cups milk, 2 eggs, 2 tbsp melted butter', '1. Mix dry ingredients\n2. Whisk wet ingredients\n3. Combine and cook on griddle', 20, 4, 1, 2, 'pancakes.jpg', 250, 6, 38, 8, 'vegetarian'),
('Avocado Toast', 'Simple and healthy breakfast', '2 slices whole grain bread, 1 avocado, salt, pepper, red pepper flakes, 2 eggs (optional)', '1. Toast bread\n2. Mash avocado and season\n3. Top toast with avocado\n4. Add fried eggs if desired', 10, 2, 1, 3, 'avocado_toast.jpg', 320, 10, 30, 18, 'vegetarian,gluten-free'),
('Vegetable Stir Fry', 'Quick and healthy vegetable dish', '2 tbsp oil, 1 onion, 2 bell peppers, 2 carrots, 1 broccoli, 3 tbsp soy sauce, 1 tbsp ginger, 2 cloves garlic', '1. Chop vegetables\n2. Heat oil in wok\n3. Stir fry vegetables\n4. Add sauce and serve', 25, 4, 5, 4, 'stirfry.jpg', 180, 5, 20, 8, 'vegetarian,vegan'),
('Chocolate Chip Cookies', 'Classic homemade cookies', '2 1/4 cups flour, 1 tsp baking soda, 1 tsp salt, 1 cup butter, 3/4 cup sugar, 3/4 cup brown sugar, 2 eggs, 2 cups chocolate chips', '1. Cream butter and sugars\n2. Add eggs\n3. Mix dry ingredients\n4. Fold in chips\n5. Bake at 375°F for 9-11 minutes', 30, 24, 4, 3, 'cookies.jpg', 150, 2, 20, 7, 'vegetarian'),
('Beef Tacos', 'Flavorful Mexican-inspired tacos', '1 lb ground beef, 1 packet taco seasoning, 8 taco shells, lettuce, tomato, cheese, sour cream', '1. Brown beef\n2. Add seasoning\n3. Prepare toppings\n4. Assemble tacos', 25, 4, 3, 2, 'tacos.jpg', 350, 20, 25, 18, NULL),
('Quinoa Salad', 'Healthy and protein-packed salad', '1 cup quinoa, 2 cups water, 1 cucumber, 1 bell pepper, 1/4 cup feta, 2 tbsp olive oil, 1 lemon', '1. Cook quinoa\n2. Chop vegetables\n3. Combine ingredients\n4. Add dressing', 20, 4, 5, 4, 'quinoa_salad.jpg', 220, 8, 30, 7, 'vegetarian,gluten-free'),
('Chicken Curry', 'Spicy and aromatic Indian curry', '1 lb chicken, 1 onion, 2 tomatoes, 2 tbsp curry powder, 1 cup coconut milk, 2 tbsp oil', '1. Sauté onions\n2. Add spices\n3. Add chicken and tomatoes\n4. Simmer with coconut milk', 45, 4, 3, 5, 'curry.jpg', 380, 30, 15, 22, 'gluten-free'),
('Vegan Brownies', 'Rich chocolate brownies without dairy', '1 cup flour, 1 cup sugar, 1/3 cup cocoa, 1/2 tsp salt, 1/2 cup vegetable oil, 1/2 cup water, 1 tsp vanilla', '1. Mix dry ingredients\n2. Add wet ingredients\n3. Bake at 350°F for 20-25 minutes', 35, 9, 6, 3, 'brownies.jpg', 200, 2, 30, 8, 'vegetarian,vegan,gluten-free');

-- Insert data into reviews table
INSERT INTO reviews (recipe_id, user_id, rating, comment) VALUES
(1, 3, 5, 'Perfect pancakes every time!'),
(1, 4, 4, 'My family loves this recipe'),
(2, 2, 5, 'So simple yet so delicious'),
(3, 5, 4, 'Great way to eat more vegetables'),
(4, 2, 5, 'Best cookies I ever made'),
(4, 3, 5, 'Always a crowd pleaser'),
(5, 4, 3, 'Good but could use more spice'),
(6, 5, 4, 'Healthy and filling'),
(7, 2, 5, 'Authentic flavor, loved it'),
(8, 4, 4, 'Can believe these are vegan!');