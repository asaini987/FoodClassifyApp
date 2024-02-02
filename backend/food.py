import requests

def fetch_food(food):

	url = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/guessNutrition"

	querystring = {"title":f"{food}"}

	headers = {
		"API-Key": "####################################",
		"API-Host": "####################################"
	}

	response = requests.get(url, headers=headers, params=querystring)
	json_data = response.json()
	calories = json_data["calories"]["value"]
	fat = json_data["fat"]["value"]
	protein = json_data["protein"]["value"]
	carbs = json_data["carbs"]["value"]
	food_info = {"calories" : calories, "fat" : fat, "protein" : protein, "carbs" : carbs}
	return food_info
