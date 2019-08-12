import Foundation

struct StarWarsPlanet: Codable {
  
  struct PlanetInfo: Codable {
    let next: String?
    let previous: String?
    let results:[StarWarsPlanet]
  }
  
  let name: String
  let rotation_period: String
  let orbital_period: String
  let climate: String
  let terrain: String
  let surface_water: String
  let residents: [String]
  let films: [String]
  let url: String
  let created: String
}
