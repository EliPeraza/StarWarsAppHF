//
//  Movie.swift
//  StarWarsAppHF
//
//  Created by Elizabeth Peraza  on 8/10/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

struct StarWarsMovie: Codable {
  
  struct MovieInfo: Codable {
    let next: String?
    let previous: String?
    let results:[StarWarsMovie]
  }
  
  let title: String?
  let episode_id: Int?
  let opening_crawl: String?
  let director: String?
  let release_date: String?
  let url: String
}
