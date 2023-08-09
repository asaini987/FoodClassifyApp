from flask import Flask, jsonify
from db_manager import DBManager
from macros import fetch_macros

app = Flask(__name__)
db = DBManager()

@app.route("/user/favfoods", methods = ["GET"])
def get_user_fav_foods(user_id):
    foods = db.get_fav_foods(user_id)
    macros = db.get_a_food(foods)
    if macros:
        # return a dictionary and jsonify it
        print("")
    else:
        # make API call to get the food's macros
        print("")
    return jsonify()

@app.route("/user/update/favfoods", methods = ["POST"])
def update_user_fav_foods(fav_foods, user_id):
    db.update_fav_food(fav_foods, user_id)

@app.route("/users/foods/scan", methods = ["GET"])
def scan_food(food_name):
    fdc_id = get_fdc_id(food_name)
    macros = fetch_macros(fdc_id)

if __name__ == "__main__":
    app.run(debug=True)
