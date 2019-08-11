//
//  Character.swift
//  StarWarsAppHF
//
//  Created by Elizabeth Peraza  on 8/10/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import Foundation

struct StarWarsCharacter: Codable {
  
  struct CharacterInfo: Codable {
    let next: String?
    let previous: String?
    let results:[StarWarsCharacter]
  }
  
  let name: String
  let height: String
  let hair_color: String
  let skin_color: String
  let eye_color: String
  let homeworld: String
  let films: [String]
  let vehicles: [String]
  let starships: [String]
  let created: String
}
