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
