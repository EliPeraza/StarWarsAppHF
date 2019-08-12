import UIKit

class PlanetsController: UIViewController {
  
  @IBOutlet weak var planetsTableView: UITableView!
  
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
    setUpTableView()
    getPlanetData()
  }
  
  func setUpTableView() {
    planetsTableView.delegate = self
    planetsTableView.dataSource = self
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
    cell.textLabel?.textColor = #colorLiteral(red: 0.9702786803, green: 0.6991387606, blue: 0.1337638199, alpha: 1)
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
  
}
