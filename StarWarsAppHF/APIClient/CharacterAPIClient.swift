//
//  CharacterAPIClient.swift
//  StarWarsAppHF
//
//  Created by Elizabeth Peraza  on 8/10/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

struct CharacterAPIClient{
  
  public static var next = String()
  public static var previous = String()
  public static var storageOfCalledData = [StarWarsCharacter]()
  
  
  static func getCharacterInfo (category:String, pageNumber: Int, completionHandler: @escaping (AppError?, [StarWarsCharacter]?) -> Void) {
    let urlString = "https://swapi.co/api/\(category)/?page=\(pageNumber)"
    
//    "https://swapi.co/api/\(category)/"
    
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
          storageOfCalledData = searchData.results
          if let thereIsNext = searchData.next{
            next = thereIsNext
          }
          if let thereIsPrevious = searchData.previous{
            previous = thereIsPrevious
          }
        } catch {
          completionHandler(AppError.jsonDecodingError(error), nil)
        }
      }
      }.resume()
  }
}
//
//  static func getMoreCharacterInfo (completionHandler: @escaping (AppError?, [StarWarsCharacter]?) -> Void) {
//    let urlString = next
//    guard let url = URL(string: urlString) else {
//      completionHandler(AppError.badURL("malformatted URL"), nil)
//      return
//    }
//
//    URLSession.shared.dataTask(with: url) { (data, response, error) in
//      if let error = error {
//        completionHandler(AppError.networkError(error), nil)
//      } else if let data = data {
//        do {
//          let searchData = try JSONDecoder().decode(StarWarsCharacter.CharacterInfo.self, from: data)
//
//          completionHandler(nil, searchData.results)
//
//          storageOfCalledData = searchData.results
//          if let thereIsNext = searchData.next{
//            next = thereIsNext
//          } else {
//            next = ""
//          }
//
//          if let thereIsPrevious = searchData.previous{
//            previous = thereIsPrevious
//          }
//        } catch {
//          completionHandler(AppError.jsonDecodingError(error), nil)
//        }
//      }
//      }.resume()
//  }
//}
