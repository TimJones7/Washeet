-- Init and/or Reset Inventory_and_Menu database

# WARNING!
-- running this script will DELETE all saved data!


-- Create Database
-- ----------------------------------------------------
DROP DATABASE IF EXISTS `Washeet.Inventory_and_Menu`;
CREATE DATABASE IF NOT EXISTS `Washeet.Inventory_and_Menu` DEFAULT CHARACTER SET utf8;
USE `Washeet.Inventory_and_Menu`;
-- ----------------------------------------------------

-- Ingredient Types Table
-- ----------------------------------------------------
DROP TABLE IF EXISTS Ingredient_Types;
CREATE TABLE IF NOT EXISTS Ingredient_Types(
	Type_id INT NOT NULL auto_increment,
	Type_name VARCHAR(30) NOT NULL,
	PRIMARY KEY(Type_id)  
);
-- ----------------------------------------------------

-- Ingredient Inventory Table
-- ----------------------------------------------------
DROP TABLE IF EXISTS Ingredient_Inv;
CREATE TABLE IF NOT EXISTS Ingredient_Inv(
	Ingredient_id INT NOT NULL auto_increment,
	Ingredient_name VARCHAR(50) NOT NULL,
	Ingredient_type_id INT,  
	Ingredient_amount INT, 
	Ingredient_units ENUM('dozen', 'grams', 'pounds', 'pieces', 'other') NOT NULL,
	PRIMARY KEY(Ingredient_id), 
	CONSTRAINT Ingredient_type_id 
		FOREIGN KEY(Ingredient_type_id) 
		REFERENCES Ingredient_Types(Type_id)  
		ON UPDATE NO ACTION
		ON DELETE SET NULL
);
-- ----------------------------------------------------

-- Ingredient Flags Table
-- ----------------------------------------------------
DROP TABLE IF EXISTS Ingredient_Flags;
CREATE TABLE IF NOT EXISTS Ingredient_Flags(
	Flag_id INT NOT NULL auto_increment,
	Flag_script VARCHAR(50) NOT NULL,
	PRIMARY KEY(Flag_id)  
);
-- ----------------------------------------------------

-- Ingredient Flag Configs Table
-- ----------------------------------------------------
DROP TABLE IF EXISTS Ingredient_Flag_Configs;
CREATE TABLE IF NOT EXISTS Ingredient_Flag_Configs(
	Ingredient_id INT NOT NULL,
	Flag_id INT NOT NULL,
	Start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	End_date DATETIME,
	CONSTRAINT Ingredient_id 
		FOREIGN KEY(Ingredient_id) 
		REFERENCES Ingredient_Inv(Ingredient_id)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	CONSTRAINT Flag_id 
		FOREIGN KEY(Flag_id) 
		REFERENCES Ingredient_Flags(Flag_id)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);
-- ----------------------------------------------------

-- Menu Item Types Table
-- ----------------------------------------------------
DROP TABLE IF EXISTS Menu_Item_Types;
CREATE TABLE IF NOT EXISTS Menu_Item_Types(
	Type_id INT NOT NULL auto_increment,
	Type_name VARCHAR(50) NOT NULL,
	PRIMARY KEY(Type_id)  
);
-- ----------------------------------------------------

 -- Menu Items Table
-- ----------------------------------------------------
DROP TABLE IF EXISTS Menu_Items;
CREATE TABLE IF NOT EXISTS Menu_Items(
	Menu_item_id INT NOT NULL auto_increment,
	Menu_item_name VARCHAR(50) NOT NULL,
	Menu_item_type_id INT,  
	PRIMARY KEY(Menu_item_id), 
	CONSTRAINT Menu_item_type_id 
		FOREIGN KEY(Menu_item_type_id) 
		REFERENCES Menu_Item_Types(Type_id)  
		ON UPDATE NO ACTION
		ON DELETE SET NULL
);
-- ----------------------------------------------------

-- Menu Item Flags Table
-- ----------------------------------------------------
DROP TABLE IF EXISTS Menu_Item_Flags;
CREATE TABLE IF NOT EXISTS Menu_Item_Flags(
	Flag_id INT NOT NULL auto_increment,
	Flag_script VARCHAR(50) NOT NULL,
	PRIMARY KEY(Flag_id)  
);
-- ----------------------------------------------------

-- Menu Item Flag Configs Table
-- ----------------------------------------------------
DROP TABLE IF EXISTS Menu_Item_Flag_Configs;
CREATE TABLE IF NOT EXISTS Menu_Item_Flag_Configs(
	Menu_item_id INT NOT NULL,
	Flag_id INT NOT NULL,
	Start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	End_date DATETIME,
	CONSTRAINT Menu_item_id 
		FOREIGN KEY(Menu_item_id) 
		REFERENCES Menu_Items(Menu_item_id)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	CONSTRAINT Flag_id 
		FOREIGN KEY(Flag_id) 
		REFERENCES Menu_Item_Flags(Flag_id)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);
-- ----------------------------------------------------

-- Menu Item Recipe Table
-- ----------------------------------------------------
DROP TABLE IF EXISTS Menu_Item_Recipe;
CREATE TABLE IF NOT EXISTS Menu_Item_Recipe(
	Menu_item_id INT NOT NULL,
	Ingredient_id INT NOT NULL,
    Ingredient_amount INT NOT NULL,
	Start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	End_date DATETIME,
	CONSTRAINT Menu_item_id 
		FOREIGN KEY(Menu_item_id) 
		REFERENCES Menu_Items(Menu_item_id)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION,
	CONSTRAINT Ingredient_id 
		FOREIGN KEY(Ingredient_id) 
		REFERENCES Ingredient_Inv(Ingredient_id)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);
-- ----------------------------------------------------

-- Menu Item Pricing Table
-- ----------------------------------------------------
DROP TABLE IF EXISTS Menu_Item_Pricing;
CREATE TABLE IF NOT EXISTS Menu_Item_Pricing(
	Menu_item_id INT NOT NULL,
	Cost DECIMAL(4,2) NOT NULL,
	Start_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	End_date DATETIME,
	CONSTRAINT Menu_item_id 
		FOREIGN KEY(Menu_item_id) 
		REFERENCES Menu_Items(Menu_item_id)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION
);
-- ----------------------------------------------------
