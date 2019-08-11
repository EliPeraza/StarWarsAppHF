import UIKit

class CharactersController: UIViewController {
  
  @IBOutlet weak var characterTableView: UITableView!
  
  let endPoint = StarWarsEndPoints.people.rawValue
  var starwarsCharacters = [StarWarsCharacter]() {
    didSet {
      DispatchQueue.main.async {
        self.characterTableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    characterTableView.delegate = self
    characterTableView.dataSource = self
    
    getCharacterData()
  }
  
  func getCharacterData (){
    CharacterAPIClient.getCharacterInfo(keyword: endPoint){(error, data) in
      DispatchQueue.main.async {
        if let error = error{
          print(error)
        }
        if let data = data {
          self.starwarsCharacters = data
          dump(self.starwarsCharacters)
        }
      }
    }
  }
  
}

extension CharactersController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return starwarsCharacters.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = characterTableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
    
    let currentCharacter = starwarsCharacters[indexPath.row]
    
    cell.textLabel?.text = currentCharacter.name
    
    return cell 
    
  }
  

}
