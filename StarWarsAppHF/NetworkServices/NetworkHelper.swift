//
//  NetworkHelper.swift
//  StarWarsAppHF
//
//  Created by Elizabeth Peraza  on 8/10/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

final class NetworkHelper {
  private init() {}
  
  static let shared = NetworkHelper()
  
  public func getStarWarsData(endPointURLString: String, completion: @escaping (Data?, AppError?) -> Void) {
    let endPointURL = "https://swapi.co/api/\(endPointURLString)/"
    
    guard let url = URL(string: endPointURL) else {
      completion(nil, AppError.badURL(endPointURL))
      return
    }
    
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let error = error {
        completion(nil, AppError.networkError(error))
      }
      guard let httpResponse = response as? HTTPURLResponse,
        (200...299).contains(httpResponse.statusCode) else {
          let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
          completion(nil, AppError.badStatusCode(String(statusCode)))
          return
      }
      if let data = data {
        completion(data, nil)
      }
    }
    task.resume()
  }
}
