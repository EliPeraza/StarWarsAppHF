import UIKit

class PlanetDetailedController: UIViewController {
  
  var planetSelectedInList: StarWarsPlanet!
  
  @IBOutlet weak var createdOn: UILabel!
  @IBOutlet weak var climateLabel: UILabel!
  @IBOutlet weak var climateDescription: UITextView!
  @IBOutlet weak var terrainLabel: UILabel!
  @IBOutlet weak var terrainDescription: UITextView!
  @IBOutlet weak var waterLabel: UILabel!
  @IBOutlet weak var waterDescription: UITextView!
  @IBOutlet weak var rotationLabel: UILabel!
  @IBOutlet weak var rotationDescription: UITextView!
  @IBOutlet weak var orbitalLabel: UILabel!
  @IBOutlet weak var orbitalDescription: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
      setUpView()
    }
    
  func setUpView() {
    title = "\(planetSelectedInList.name)"
    
    let date = planetSelectedInList.created.date()
    createdOn.text = "Database entry created on: \(date)"
    climateLabel.text = "Climate:"
    terrainLabel.text = "Terrain:"
    waterLabel.text = "Water on surface:"
    rotationLabel.text = "Rotation period:"
    orbitalLabel.text = "Orbital period:"
    
    climateDescription.text = "The climate in \(planetSelectedInList.name) is usually \(planetSelectedInList.climate)."
    terrainDescription.text = " \(planetSelectedInList.terrain.capitalized) terrain."
    waterDescription.text = "This planet has a \(planetSelectedInList.surface_water)% of surface water."
    rotationDescription.text = "\(planetSelectedInList.name.capitalized) has a rotation period of \(planetSelectedInList.rotation_period) years."
    orbitalDescription.text = "\(planetSelectedInList.orbital_period) is \(planetSelectedInList.name.capitalized)'s orbital period."
  }
   

}
