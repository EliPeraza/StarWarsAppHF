import UIKit

class CharacterDetailedController: UIViewController {
  
  public var currentCharacter: StarWarsCharacter!
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var homePlanetLabel: UILabel!
  
  @IBOutlet weak var heightLabel: UILabel!
  
  @IBOutlet weak var eyeColorLabel: UILabel!
  
  @IBOutlet weak var hairColorLabel: UILabel!
  
  @IBOutlet weak var vehicleTableView: UITableView!
  
  @IBOutlet weak var createdOnLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableView()
    setUpUI()
  }
  
  func setUpTableView(){
    vehicleTableView.delegate = self
    vehicleTableView.dataSource = self
  }
  
  func setUpUI() {
    title = "Profile"
    nameLabel.text = currentCharacter.name
    homePlanetLabel.text = currentCharacter.homeworld
    heightLabel.text = "Height: \(currentCharacter.height) cm."
    eyeColorLabel.text = "Eye color: \(currentCharacter.eye_color)"
    hairColorLabel.text = "Hair color: \(currentCharacter.hair_color)"
    let date  = currentCharacter.created.date()
    createdOnLabel.text = "Database entry created on: \(date)"
  }
  
//  func findHomeWorld(arrayOfPlanet: [StarWarsPlanet.PlanetInfo], urlString: String) -> String {
//    var planetName = ""
//    for planet in arrayOfPlanet {
//      print(planet)
//    }
//    return planetName
//  }
}

extension CharacterDetailedController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentCharacter.starships.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = vehicleTableView.dequeueReusableCell(withIdentifier: "vehicleShipCell", for: indexPath)
    let currentVehicle = currentCharacter.starships[indexPath.row]
    cell.textLabel?.text = currentVehicle
    return cell
  }
}
