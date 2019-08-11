//
//  CharacterAPIClient.swift
//  StarWarsAppHF
//
//  Created by Elizabeth Peraza  on 8/10/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

struct CharacterAPIClient{
  
  static func getCharacterInfo (keyword:String, completionHandler: @escaping (AppError?, [StarWarsCharacter]?) -> Void) {
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
          let searchData = try JSONDecoder().decode(StarWarsCharacter.CharacterInfo.self, from: data)
          
          completionHandler(nil, searchData.results)
        } catch {
          completionHandler(AppError.jsonDecodingError(error), nil)
        }
      }
      }.resume()
  }
}
