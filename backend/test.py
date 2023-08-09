import requests


def testApi(food):

	url = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/guessNutrition"

	querystring = {"title":f"{food}"}

	headers = {
		"X-RapidAPI-Key": "52fdffb06dmsh7982e277106ecdap1999bajsn9e3f14455072",
		"X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
	}

	response = requests.get(url, headers=headers, params=querystring)
	return response.json()



f=open('foods.txt','r')

list_foods=f.readlines()

response=testApi(list_foods[0])


for food in list_foods:
    response=testApi(food)
    if "error" in response.keys():
        print(f'Test failed for {food}')
        break
print("All tests passed")

