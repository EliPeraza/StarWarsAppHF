import Foundation

struct MovieAPIClient{
  
  static func getMovieInfo (keyword:String, completionHandler: @escaping (AppError?, [StarWarsMovie]?) -> Void) {
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
          let searchData = try JSONDecoder().decode(StarWarsMovie.MovieInfo.self, from: data)
          
          completionHandler(nil, searchData.results)
        } catch {
          completionHandler(AppError.jsonDecodingError(error), nil)
        }
      }
      }.resume()
  }
}

//  static func decodeData(endPoint: String, completionHandler: @escaping ([StarWarsMovie]?, AppError?) -> Void) {
//    let url = "https://swapi.co/api/\(endPoint)/"
//    NetworkHelper.shared.getStarWarsData(endPointURLString: url) { (data, appError) in
//      if appError != nil {
//       completionHandler(nil, AppError.badURL("Bad URL \(url)"))
//      }
//      if let data = data {
//        do {
//          let starWarsData = try JSONDecoder().decode(StarWarsMovie.MovieInfo.self, from: data)
//          completionHandler(starWarsData.results, nil)
//        } catch {
//          completionHandler(nil, AppError.jsonDecodingError(error))
//        }
//      }
//    }
//  }
//
//
//  static func decodeSearchData(endPoint: StarWarsEndPoints, searchKeyWord: String?, completionHandler: @escaping ([StarWarsMovie]?, AppError?) -> Void) {
//    var url =  String()
//    if let keyWord = searchKeyWord {
//      url = "https://swapi.co/api/\(endPoint)/?search=\(keyWord)"
//    } else {
//      url = "https://swapi.co/api/\(endPoint)/"
//    }
//    NetworkHelper.shared.getStarWarsData(endPointURLString: url) { (data, appError) in
//      if appError != nil {
//        completionHandler(nil, AppError.badURL("Bad URL"))
//      }
//      if let data = data {
//        do {
//          let starWarsData = try JSONDecoder().decode(StarWarsMovie.MovieInfo.self, from: data)
//          completionHandler(starWarsData.results, nil)
//        } catch {
//          completionHandler(nil, AppError.jsonDecodingError(error))
//        }
//      }
//    }
//  }
//}
