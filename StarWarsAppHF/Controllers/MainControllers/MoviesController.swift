//import UIKit
//
//class MoviesController: UIViewController {
//  
//  @IBOutlet weak var moviesCollectionView: UICollectionView!
//  
//  let endPoint = StarWarsEndPoints.films.rawValue
//  var pageNumber = 1
//  var movies = [StarWarsMovie]() {
//    didSet {
//      DispatchQueue.main.async {
//        self.moviesCollectionView.reloadData()
//      }
//    }
//  }
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    configureCollection()
//    getMovieData()
//  }
//  
//  func getMovieData (){
//    MovieAPIClient.getMovieInfo(keyword: endPoint, pageNumber: pageNumber){(error, data) in
//      DispatchQueue.main.async {
//        if let error = error{
//          print(error)
//        }
//        if let data = data {
//          self.movies = data
//          self.pageNumber += 1
//        }
//      }
//    }
//  }
//  
//  func configureCollection(){
//    moviesCollectionView.dataSource = self
//    moviesCollectionView.delegate = self
//    let layout = self.moviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//    layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//    layout.minimumInteritemSpacing = 5
//    layout.itemSize = CGSize(width: (self.moviesCollectionView.frame.size.width - 20)/2, height: self.moviesCollectionView.frame.size.height/3)
//  }
//}
//
//extension MoviesController: UICollectionViewDataSource {
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return movies.count
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    guard let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {return UICollectionViewCell()}
//    
//    let currentMovie = movies[indexPath.row]
//    
//    cell.movieName.text = currentMovie.title
//    cell.movieName.textColor = #colorLiteral(red: 0.9702786803, green: 0.6991387606, blue: 0.1337638199, alpha: 1)
//
//    if let foundFilmTitle = currentMovie.title, let image = returnAPoster(movieName: foundFilmTitle){
//      cell.categoryImage.image = image
//    }
//    
//    cell.layer.cornerRadius = 5.0
//    cell.layer.borderColor = #colorLiteral(red: 0.9702786803, green: 0.6991387606, blue: 0.1337638199, alpha: 1)
//    cell.layer.borderWidth = 1.0
//    
//    return cell
//  }
//  
//  func returnAPoster(movieName: String) -> UIImage? {
//    var image = UIImage()
//    let formattedString = movieName.replacingOccurrences(of: " ", with: "").lowercased()
//    for value in MoviePoster.allCases {
//      if value.rawValue == formattedString {
//        if let foundImage = UIImage(named: value.rawValue){
//          image = foundImage
//        }
//      }
//    }
//    return image
//  }
//  
//}
//
//extension MoviesController: UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    return CGSize(width: 300, height: 300)
//  }
//  
//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    let currentMovie = movies[indexPath.row]
//    guard let cell = moviesCollectionView.cellForItem(at: indexPath) as? MovieCell else { print("didSelectItemAt cell is nill")
//      return
//    }
//    let detailedVC = MovieDetailedController()
//    detailedVC.movieCrawl = currentMovie.opening_crawl
//    detailedVC.movie = currentMovie
//    detailedVC.moviePoster.image = cell.categoryImage.image
//    navigationController?.pushViewController(detailedVC, animated: true)
//    
//  }
//}
