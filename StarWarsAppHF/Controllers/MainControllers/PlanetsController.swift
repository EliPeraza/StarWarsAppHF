import UIKit

class PlanetsController: UIViewController {
  
  @IBOutlet weak var planetsTableView: UITableView!
  
  let endPoint = StarWarsEndPoints.planets.rawValue
  var starwarsPlanets = [StarWarsPlanet]() {
    didSet {
      DispatchQueue.main.async {
        self.planetsTableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    planetsTableView.delegate = self
    planetsTableView.dataSource = self
    
    getPlanetData()
  }
  
  func getPlanetData (){
    PlanetAPIClient.getPlanetInfo(keyword: endPoint){(error, data) in
      DispatchQueue.main.async {
        if let error = error{
          print(error)
        }
        if let data = data {
          self.starwarsPlanets = data
          dump(self.starwarsPlanets)
        }
      }
    }
  }
  
}

extension PlanetsController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return starwarsPlanets.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = planetsTableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath)
    
    let currentCharacter = starwarsPlanets[indexPath.row]
    
    cell.textLabel?.text = currentCharacter.name
    
    return cell
    
  }
  

}
