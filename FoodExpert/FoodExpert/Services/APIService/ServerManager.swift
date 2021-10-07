

import UIKit

//Recipe
struct RecipeTotalNutrient: Decodable {
    var CHOCDF: RecipeNutrient
    var FAT: RecipeNutrient
    var PROCNT: RecipeNutrient
}

struct RecipeNutrient: Decodable {
    var label: String
    var quantity: Float
    var unit: String
}

struct RecipeHit: Decodable {
    var recipe: Recipe
}

struct Recipe: Decodable {
    var label: String
    var image: String
    var ingredientLines: [String]
    var calories: Float
    var mealType: [String]
    var dietLabels: [String]
    var totalNutrients: RecipeTotalNutrient
}

fileprivate struct RecipeServerResponse: Decodable {
    var hits: [RecipeHit]
}

//Food
struct FoodHint: Decodable {
    var food: Food
    var measures: [Measure]
}

struct FoodNutrient: Decodable {
    var ENERC_KCAL: Float
    var PROCNT: Float
    var FAT: Float
    var CHOCDF: Float
}

struct Measure: Decodable{
    var uri: String
    var label: String
    var weight: Float
}
struct Food: Decodable {
    var label: String
    var nutrients: FoodNutrient
    var brand: String?
    var category: String
}

fileprivate struct FoodServerResponse: Decodable {
    var hints: [FoodHint]
}

class ServerManager: NSObject {
    
    static let shared = ServerManager()
    
    func getRceipts(q: String, mealType: String, completion: @escaping ([Recipe]) -> Void) {
        let queryItems = [
            URLQueryItem(name: "app_id", value: "a2f626ad"),
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "mealType", value: mealType),
            URLQueryItem(name: "app_key", value: "2a2d403a2dd5412b776f7d5a768158fe")
        ]
        var urlComps = URLComponents(string: "https://api.edamam.com/api/recipes/v2")!
        urlComps.queryItems = queryItems
        URLSession.shared.dataTask(with: URLRequest(url: urlComps.url!)) { data, response, error in
            do {
                if let data = data {
                    let responseObject = try JSONDecoder().decode(
                        RecipeServerResponse.self,
                        from: data
                    )
                    
                    var recieps: [Recipe] = []
                    
                    for object in responseObject.hits {
                        recieps.append(object.recipe)
                    }
                    
                    completion(recieps)
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getFood(ingr: String, completion: @escaping ([FoodHint]) -> Void) {
        let queryItems = [
            URLQueryItem(name: "app_id", value: "5583a1f1"),
            URLQueryItem(name: "ingr", value: ingr),
            URLQueryItem(name: "app_key", value: "b734a53c63c6e345f4b485f97142c164")
        ]
        var urlComps = URLComponents(string: "https://api.edamam.com/api/food-database/v2/parser")!
        urlComps.queryItems = queryItems
        URLSession.shared.dataTask(with: URLRequest(url: urlComps.url!)) { data, response, error in
            do {
                if let data = data {
                    let responseObject = try JSONDecoder().decode(
                        FoodServerResponse.self,
                        from: data
                    )
                    completion(responseObject.hints)
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }.resume()
    }
    
}



