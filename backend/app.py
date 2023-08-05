from flask import Flask, jsonify, request, json
from db_manager import DBManager

app = Flask(__name__)
db = DBManager()

@app.route("/user/favfoods", methods = ["GET"])
def get_user_fav_foods(user_id):
    foods = db.get_fav_foods(user_id)
    macros = db.get_a_food(foods)
    if macros:
        # return a dictionary and jsonify it
    else:
        # make API call to get the food's macros
    return jsonify(response)

@app.route("/user/update/favfoods", methods = ["POST"])
def update_user_fav_foods(fav_foods, user_id):
    db.update_fav_food(fav_foods, user_id)

if __name__ == "__main__":
    app.run(debug=True)
