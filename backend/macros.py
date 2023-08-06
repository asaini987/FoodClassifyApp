import requests

def fetch_macros(fdc_id): #function sends fdc_id to API and fetches the macros and returns them as a dictionary
    url = f"https://api.nal.usda.gov/fdc/v1/food/{fdc_id}?nutrients=203&nutrients=204&nutrients=205&nutrients=208&api_key=#####"
    response = requests.get(url)
    food_data = response.json()

    food_description = food_data["description"]
    nutrient_list = food_data["foodNutrients"]
    macros = {"Name" : food_description}
    
    for nutrient_info in nutrient_list:
        name = nutrient_info["nutrient"]["name"]
        unit = nutrient_info["nutrient"]["unitName"]
        amount = nutrient_info["amount"]

        macros.update({name : f"{amount}{unit}"})

    return macros
