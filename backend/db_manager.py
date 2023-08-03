import sqlite3
from sqlite3 import Error

class DBManager:
    def __init__(self):
        try:
            self.conn = sqlite3.connect("recipeAI.db")
            self.c = self.conn.cursor()
            self.c.execute("PRAGMA foreign_keys = ON")
            self.create_tables()

        except Error as e:
            self.conn = None
            self.c = None
            print(e)

    def create_tables(self):
        try:
            users_table_query = '''CREATE TABLE IF NOT EXISTS users (
                                        user_id INTEGER PRIMARY KEY,
                                        fav_foods TEXT  
                                )'''
            food_table_query = '''CREATE TABLE IF NOT EXISTS foods (
                                    name TEXT PRIMARY KEY,
                                    protein INTEGER,
                                    carbs INTEGER,
                                    fat INTEGER,
                                    calories INTEGER,
                                    recipe TEXT
                                )'''
            food_entry_records_table_query = '''CREATE TABLE IF NOT EXISTS food_entry_records (
                                                        diner_id INTEGER NOT NULL,
                                                        food_name TEXT NOT NULL,
                                                        consumption_date TEXT NOT NULL,
                                                        FOREIGN KEY (diner_id) REFERENCES users (user_id)
                                                )'''
            self.c.execute(users_table_query)
            self.c.execute(food_table_query)
            self.c.execute(food_entry_records_table_query)
            self.conn.commit()
            
        except Error as e:
            print(e)
    
    def close_connection(self):
        self.conn.close()

    #CRUD operations

    def insert_user(self, user_id):
        try:
            insert_user_query = "INSERT INTO users (user_id) VALUES (?)"
            user_ids_to_insert = (user_id,)
            self.c.execute(insert_user_query, user_ids_to_insert)
            self.conn.commit()
        except Error as e:
                print(e)
    
    def update_fav_food(self, food, user_id):
        try:
            update_fav_food_query = "UPDATE users SET fav_foods = ? WHERE user_id = ?"
            data_to_update = (food, user_id)
            self.c.execute(update_fav_food_query, data_to_update)
            self.conn.commit()
        except Error as e:
            print(e)
    
    def insert_food(self, name, protein, carbs, fat, calories, recipe):
        try:
            insert_food_query = '''INSERT INTO foods (name, protein, carbs, fat, calories, recipe)
                                    VALUES (?,?,?,?,?,?)'''
            food_data_to_insert = (name, protein, carbs, fat, calories, recipe)
            self.c.execute(insert_food_query, food_data_to_insert)
            self.conn.commit()
        except Error as e:
            print(e)
    
    def insert_food_entry(self, diner_id, food_name, consumption_date):
        try:
            insert_food_entry_query = '''INSERT INTO food_entry_records (diner_id, food_name, consumption_date) 
                                        VALUES (?,?,?)'''
            food_entry_to_insert = (diner_id, food_name, consumption_date)
            self.c.execute(insert_food_entry_query, food_entry_to_insert)
            self.conn.commit()
        except Error as e:
            print(e)

    def get_a_food(self, name): #returns a tuple of row values
        try:
            get_food_query = '''SELECT name, protein, carbs, fat, calories, recipe
                                FROM foods WHERE name = ?'''
            requested_food_name = (name,)
            self.c.execute(get_food_query, requested_food_name)
            result = self.c.fetchone()
            return result
        except Error as e:
            print(e)
    
    def get_fav_foods(self, user_id):
        try:
            get_fav_foods_query = "SELECT fav_foods FROM users WHERE user_id = ?"
            requested_user_id = (user_id,)
            self.c.execute(get_fav_foods_query, requested_user_id)
            result = self.c.fetchone()
            return result
        except Error as e:
            print(e)

