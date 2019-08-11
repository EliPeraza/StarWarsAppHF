//
//  StarWarsAPIClient.swift
//  StarWarsAppHF
//
//  Created by Elizabeth Peraza  on 8/11/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

//struct StarWarsAPIClient {
//  
//  static func getStarWarsInfo<T: Decodable>(category:StarWarsEndPoints, pageNumber: Int, completionHandler: @escaping (AppError?, [T]?) -> Void) {
//    let urlString = "https://swapi.co/api/\(category)/?page=\(pageNumber)"
//    guard let url = URL(string: urlString) else {
//      completionHandler(AppError.badURL("malformatted URL"), nil)
//      return
//    }
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//      if let error = error {
//        completionHandler(AppError.networkError(error), nil)
//      } else if let data = data {
//        do {
//          switch category{
//          case .films:
//            let searchData = try JSONDecoder().decode([StarWarsMovie.MovieInfo.self], from: data)
//            completionHandler(nil, searchData.results.self)
//          case .people:
//            let searchData = try JSONDecoder().decode(StarWarsCharacter.CharacterInfo.self, from: data)
//            completionHandler(nil, searchData.results.self)
//          case .planets:
//            let searchData = try JSONDecoder().decode(StarWarsPlanet.PlanetInfo.self, from: data)
//            completionHandler(nil, searchData.results.self)
//          }
//        } catch {
//          completionHandler(AppError.jsonDecodingError(error), nil)
//        }
//      }
//      }.resume()
//  }
//}
