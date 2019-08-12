import UIKit

class CharactersController: UIViewController {
  
  @IBOutlet weak var characterTableView: UITableView!
  
  var pageNumber = 1
  var isFetching = false
  let endPoint = StarWarsEndPoints.people.rawValue
  
  var storeCalledData = [StarWarsCharacter]() {
    didSet {
      DispatchQueue.main.async {
        self.characterTableView.reloadData()
      }
    }
  }
  
  var starwarsCharacters = [StarWarsCharacter]() {
    didSet {
      DispatchQueue.main.async {
        self.characterTableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableViews()
    getCharacterData()
  }
  
  func setUpTableViews() {
    characterTableView.delegate = self
    characterTableView.dataSource = self
  }
  
  func getCharacterData (){
    CharacterAPIClient.getCharacterInfo(category: endPoint, pageNumber: pageNumber){(error, data) in
      DispatchQueue.main.async {
        if let error = error{
          print(error)
        }
        if let data = data {
          self.starwarsCharacters = data
          self.storeCalledData.append(contentsOf: self.starwarsCharacters)
          self.pageNumber += 1
          self.isFetching = false
        }
      }
    }
  }
  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "CharactersDetailedSegue" {
//        guard let indexPath = sender as? IndexPath,
//          let charcatersDetailedVC = segue.destination as? CharacterDetailedController else {
//       fatalError("cannot segue to Characters Detailed View Controller")
//      }
//      let currentCharacter = storeCalledData[indexPath.row]
//      charcatersDetailedVC.currentStarWarsCharacter = currentCharacter
//    }
//  }
  
}


extension CharactersController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return storeCalledData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = characterTableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
    
    let currentCharacter = storeCalledData[indexPath.row]
    cell.textLabel?.text = currentCharacter.name
    
    cell.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
    return cell
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offSetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    if offSetY > contentHeight - scrollView.frame.height {
      if !isFetching {
        fetchMoreCharacters()
      }
    }
  }
  
  func fetchMoreCharacters() {
    isFetching = true
    self.getCharacterData()
    self.characterTableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailedViewController = CharacterDetailedController()
    let currentCharacter = storeCalledData[indexPath.row]
    detailedViewController.currentStarWarsCharacter = currentCharacter
    detailedViewController.name = currentCharacter.name
    
    navigationController?.pushViewController(detailedViewController, animated: true)
  }
}
