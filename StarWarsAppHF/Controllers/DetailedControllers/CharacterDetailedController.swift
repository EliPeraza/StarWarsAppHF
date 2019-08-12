import UIKit

class CharacterDetailedController: UIViewController {

  var name: String = "Anonymous"
  
  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var homePlanetLabel: UILabel!
  
  @IBOutlet weak var heightLabel: UILabel!
  
  @IBOutlet weak var eyeColorLabel: UILabel!
  
  @IBOutlet weak var hairColorLabel: UILabel!
  
  @IBOutlet weak var vehicleTableView: UITableView!
  
  var currentStarWarsCharacter: StarWarsCharacter?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
  
  func setUpTableView(){
    title = "Profile"
    nameLabel.text = name 
   
  }


}
