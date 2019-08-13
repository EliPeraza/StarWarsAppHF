import UIKit

class PlanetsController: UIViewController {
  
  @IBOutlet weak var planetsTableView: UITableView!
  @IBOutlet weak var planetSearchBar: UISearchBar!
  
  var pageNumber = 1
  var isFetching = false
  let endPoint = StarWarsEndPoints.planets.rawValue
  var storedPlanetsData = [StarWarsPlanet]() {
    didSet {
      DispatchQueue.main.async {
        self.planetsTableView.reloadData()
      }
    }
  }
  var starwarsPlanets = [StarWarsPlanet]() {
    didSet {
      DispatchQueue.main.async {
        self.planetsTableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Planets"
    setUpDelegates()
    getPlanetData()
  }
  
  func setUpDelegates() {
    planetsTableView.delegate = self
    planetsTableView.dataSource = self
    planetSearchBar.delegate = self
  }
  
  func getPlanetData (){
    PlanetAPIClient.getPlanetInfo(keyword: endPoint, pageNumber: pageNumber){(error, data) in
      DispatchQueue.main.async {
        if let error = error{
          print(error)
        }
        if let planetData = data {
          self.starwarsPlanets = planetData
          self.storedPlanetsData.append(contentsOf: self.starwarsPlanets)
          self.pageNumber += 1
          self.isFetching = false
        }
      }
    }
  }
  func getUserSearch(searchedText: String) {
 PlanetAPIClient.userSearchForPlanet(category: endPoint, planetName: searchedText){(error, data) in
        DispatchQueue.main.async {
          if let error = error{
            print(error)
          }
          if let planetData = data {
            self.starwarsPlanets.append(contentsOf: self.storedPlanetsData)
            self.storedPlanetsData = planetData
            self.isFetching = false
          }
        }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = planetsTableView.indexPathForSelectedRow,
      let detailedPlanetController = segue.destination as? PlanetDetailedController else {fatalError("Error with segue")}
    let currentPlanet = storedPlanetsData[indexPath.row]
    detailedPlanetController.planetSelectedInList = currentPlanet
  }
}

extension PlanetsController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return storedPlanetsData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = planetsTableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath)
    let currentPlanet = storedPlanetsData[indexPath.row]
    cell.textLabel?.text = currentPlanet.name
    cell.backgroundColor = .black
    cell.textLabel?.textAlignment = .center
    cell.textLabel?.textColor = #colorLiteral(red: 0.996571362, green: 0.9003907442, blue: 0.02927687764, alpha: 1)
    cell.textLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 20)
    cell.heightAnchor.constraint(equalToConstant: 100).isActive = true
    return cell
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offSetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    if offSetY > contentHeight - scrollView.frame.height {
      if !isFetching {
        fetchMorePlanets()
      }
    }
  }
  
  func fetchMorePlanets() {
    isFetching = true
    self.getPlanetData()
    self.planetsTableView.reloadData()
  }
}

extension PlanetsController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    guard let searchText = searchBar.text?.lowercased(),
      !searchText.isEmpty else {
        return
    }
    getUserSearch(searchedText: searchText)
    planetsTableView.reloadData()
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text?.lowercased() else {
     return
    }
    if searchText.isEmpty {
     self.storedPlanetsData = self.starwarsPlanets
      planetsTableView.reloadData()
    }
  }

}
