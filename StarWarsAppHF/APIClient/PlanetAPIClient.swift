import Foundation

struct PlanetAPIClient{
  
  static func getPlanetInfo(keyword:String, pageNumber: Int, completionHandler: @escaping (AppError?, [StarWarsPlanet]?) -> Void) {
    let urlString = "https://swapi.co/api/\(keyword)/"
    
    guard let url = URL(string: urlString) else {
      completionHandler(AppError.badURL("malformatted URL"), nil)
      return
    }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completionHandler(AppError.networkError(error), nil)
      } else if let data = data {
        do {
          
          let searchData = try JSONDecoder().decode(StarWarsPlanet.PlanetInfo.self, from: data)
          
          completionHandler(nil, searchData.results)
        } catch {
          completionHandler(AppError.jsonDecodingError(error), nil)
        }
      }
      }.resume()
  }
}
