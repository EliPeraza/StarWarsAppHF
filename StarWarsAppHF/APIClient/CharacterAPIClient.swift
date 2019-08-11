import Foundation

struct CharacterAPIClient {
  
  static func getCharacterInfo (category:String, pageNumber: Int, completionHandler: @escaping (AppError?, [StarWarsCharacter]?) -> Void) {
    let urlString = "https://swapi.co/api/\(category)/?page=\(pageNumber)"
    
    guard let url = URL(string: urlString) else {
      completionHandler(AppError.badURL("malformatted URL"), nil)
      return
    }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completionHandler(AppError.networkError(error), nil)
      } else if let data = data {
        do {
          let searchData = try JSONDecoder().decode(StarWarsCharacter.CharacterInfo.self, from: data)
          completionHandler(nil, searchData.results)
        } catch {
          completionHandler(AppError.jsonDecodingError(error), nil)
        }
      }
      }.resume()
  }
}
