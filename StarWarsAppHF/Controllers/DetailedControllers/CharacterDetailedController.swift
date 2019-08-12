import UIKit

class CharacterDetailedController: UIViewController {
  
  public var currentCharacter: StarWarsCharacter!
  let endPoint = StarWarsEndPoints.films.rawValue
  var pageNumber = 1
  var movies = [StarWarsMovie]() {
    didSet {
      DispatchQueue.main.async {
        self.moviesCollectionView.reloadData()
      }
    }
  }
  
  
  @IBOutlet weak var birthYearLbel: UILabel!
  @IBOutlet weak var backGroundImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var heightLabel: UILabel!
  @IBOutlet weak var eyeColorLabel: UILabel!
  @IBOutlet weak var hairColorLabel: UILabel!
  @IBOutlet weak var createdOnLabel: UILabel!
  @IBOutlet weak var moviesLabel: UILabel!
  @IBOutlet weak var moviesCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollection()
    getMovieData()
    setupUI()
  }
  
  func getMovieData (){
    MovieAPIClient.getMovieInfo(keyword: endPoint, pageNumber: pageNumber){(error, data) in
      DispatchQueue.main.async {
        if let error = error{
          print(error)
        }
        if let data = data {
          self.movies = data
          self.pageNumber += 1
        }
      }
    }
  }
  
  func setupUI(){
    backGroundImage.image = UIImage(named: "deathStar")
    birthYearLbel.text = "Birth year: \(currentCharacter.birth_year)"
    nameLabel.text = currentCharacter.name.uppercased()
    heightLabel.text = "Height: \(currentCharacter.height) cm."
    eyeColorLabel.text = "Eye color: \(currentCharacter.eye_color)."
    hairColorLabel.text = "Hair color: \(currentCharacter.hair_color)."
    moviesLabel.text = "Movies \(currentCharacter.name) appears in:"
    createdOnLabel.text = "Date: \(currentCharacter.created.dateFormatAdjustment(dateString: currentCharacter.created))"
  }
  
  func configureCollection(){
    moviesCollectionView.dataSource = self
    moviesCollectionView.delegate = self
    let layout = self.moviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    layout.minimumInteritemSpacing = 5
    layout.itemSize = CGSize(width: (self.moviesCollectionView.frame.size.width - 20)/2, height: self.moviesCollectionView.frame.size.height/3)
    moviesCollectionView.backgroundColor = .black
  }
  
  @IBAction func backButton(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
}

extension CharacterDetailedController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {return UICollectionViewCell()}
    let currentMovie = movies[indexPath.row]
    if let foundFilmTitle = currentMovie.title, let image = returnAPoster(movieName: foundFilmTitle){
      cell.categoryImage.image = image
    }
    cell.layer.cornerRadius = 5.0
    cell.layer.borderColor = #colorLiteral(red: 0.9702786803, green: 0.6991387606, blue: 0.1337638199, alpha: 1)
    cell.layer.borderWidth = 1.0
    return cell
  }
  
  func returnAPoster(movieName: String) -> UIImage? {
    var image = UIImage()
    let formattedString = movieName.replacingOccurrences(of: " ", with: "").lowercased()
    for value in MoviePoster.allCases {
      if value.rawValue == formattedString {
        if let foundImage = UIImage(named: value.rawValue){
          image = foundImage
        }
      }
    }
    return image
  }
}

extension CharacterDetailedController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 240, height: 240)
  }
}
