from flask import Flask, jsonify, request
from db_manager import DBManager
from food import fetch_food

app = Flask(__name__)
db = DBManager()

@app.route("/get_favfoods", methods = ["GET"])
def get_user_fav_foods():
    user_id = request.args.get("user_id")
    foods = db.get_fav_foods(user_id)
    if foods:
        # return a dictionary and jsonify it
        return jsonify({"favFoods" : foods})
    else:
        return jsonify({"error" : "Resource not found"}), 404
    
@app.route("/insert_favfood", methods = ["POST"])
def insert_fav_food():
    user_id = request.args.get("user_id")
    food = request.args.get("food")
    if food and user_id:
        db.insert_fav_food(user_id, food)

@app.route("/update_favfood", methods = ["POST"])
def update_user_fav_foods():
    response = request.get_json()
    fav_food = response.get("favFood")
    user_id = response.get("user_id")
    if user_id and fav_food:
        db.update_fav_food(fav_food, user_id)
    else:
        response_data = {"error": "Resource not found"}
        return jsonify(response_data), 404

@app.route("/get_food_info", methods = ["POST"])
def get_food_info():
    response = request.get_json()
    food_name = response.get("foodName")
    food_info = fetch_food(food_name)
    return jsonify(food_info)

@app.route("/insert_user", methods = ["POST"])
def add_user():
    response = request.get_json()
    user_id = response.get("userId")
    db.insert_user(user_id)
 
@app.route("/log_food", methods = ["POST"])
def log_food():
    food_info = request.get_json()
    db.insert_food_entry(food_info["diner_id"], food_info["food_name"], food_info["consumption_date"])

@app.route("/get_food_logs", methods = ["POST"])
def get_food_logs():
    response = request.get_json()
    user_id = response.get("user_id")
    food_entries = db.get_food_entries(user_id)
    if food_entries:
        return jsonify({"foodEntries" : food_entries})

if __name__ == "__main__":
    app.run(debug=True)
