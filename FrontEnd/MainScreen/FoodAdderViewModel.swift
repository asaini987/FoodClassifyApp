import Foundation

class FoodAdderViewModel: ObservableObject {
    
    func addFood(food: String) async -> String {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: ["food" : food]) else {
            return "Could not convert to JSON"
        }
        
        guard let url = URL(string: "http://example_API/insert_favfood") else {
                return "Invalid URL"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Sending request and decoding response
        do {
            let _ = try await URLSession.shared.upload(for: request, from: jsonData)
            return "Successfully added food"
            
        } catch {
            print(error.localizedDescription)
            return "No food added"
        }
    }
    
    func getFoodInfo(food: String) async -> String {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: ["food" : food]) else {
            return "Could not convert to JSON"
        }
        
        guard let url = URL(string: "http://example_API/get_food_info") else {
                return "Invalid URL"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Sending request and decoding response
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: jsonData)
            guard let response = try? JSONDecoder().decode(FoodInfo.self, from: data) else {
                        return "Couldn't decode JSON"
            }
            return "Calories: \(response.calories), Protein: \(response.protein), Carbs: \(response.carbs), Fat: \(response.fat)"
            
        } catch {
            print(error.localizedDescription)
            return "No food added"
        }
    }
}

struct FoodInfo: Codable {
    let calories: Float
    let fat: Float
    let protein: Float
    let carbs: Float
}
