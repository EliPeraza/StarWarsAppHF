import UIKit

class CharactersController: UIViewController {
  
  @IBOutlet weak var characterTableView: UITableView!
  @IBOutlet weak var logo: UIImageView!
  
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
    title = "People"
    setUpTableViews()
    getCharacterData()
    setupUI()
  }
  
  func setUpTableViews() {
    characterTableView.delegate = self
    characterTableView.dataSource = self
    characterTableView.backgroundColor = .black
  }
  
  func setupUI(){
    logo.image = UIImage(named: "starWarsNewLogo")
  }
  
  func getCharacterData (){
    CharacterAPIClient.getCharacterInfo(category: endPoint, pageNumber: pageNumber){[weak self] (error, data) in
      if let error = error{
        print(error)
      }
      if let data = data {
        self?.starwarsCharacters = data
        self!.storeCalledData.append(contentsOf: self!.starwarsCharacters)
        self?.pageNumber += 1
        self?.isFetching = false
      }
    }
  }
}

extension CharactersController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return storeCalledData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = characterTableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
    let currentCharacter = storeCalledData[indexPath.row]
    cell.textLabel?.text = currentCharacter.name
    cell.textLabel?.textColor = #colorLiteral(red: 0.996571362, green: 0.9003907442, blue: 0.02927687764, alpha: 1)
    cell.textLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 20)
    cell.textLabel?.textAlignment = .center
    cell.backgroundColor = .black
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
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    guard let detailedCharacterController = storyboard.instantiateViewController(withIdentifier: "CharacterDetailedController") as? CharacterDetailedController else {return}
    detailedCharacterController.modalPresentationStyle = .overCurrentContext
    detailedCharacterController.currentCharacter = storeCalledData[indexPath.row]
    present(detailedCharacterController, animated: true, completion: nil)
    
    
  }
}
