import UIKit

class MoviesController: UIViewController {
  
  @IBOutlet weak var moviesCollectionView: UICollectionView!
  
  let endPoint = StarWarsEndPoints.films.rawValue
  var movies = [StarWarsMovie]() {
    didSet {
      DispatchQueue.main.async {
        self.moviesCollectionView.reloadData()
      }
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    moviesCollectionView.dataSource = self
    moviesCollectionView.delegate = self
    getMovieData()
    configureCollection()
  }
  
  func getMovieData (){
    MovieAPIClient.getMovieInfo(keyword: endPoint){(error, data) in
      DispatchQueue.main.async {
        if let error = error{
          print(error)
        }
        if let data = data {
          self.movies = data
          dump(self.movies)
        }
      }
    }
  }
  
  func configureCollection(){
    let layout = self.moviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
    layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    layout.minimumInteritemSpacing = 5
    layout.itemSize = CGSize(width: (self.moviesCollectionView.frame.size.width - 20)/2, height: self.moviesCollectionView.frame.size.height/3)
  }
}

extension MoviesController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell else {return UICollectionViewCell()}
    
    let currentMovie = movies[indexPath.row]
    
    cell.movieName.text = currentMovie.title
    
    cell.layer.cornerRadius = 5.0
    cell.layer.borderColor = #colorLiteral(red: 0.4309224188, green: 0.5425195694, blue: 0.6682616472, alpha: 1)
    cell.layer.borderWidth = 1.0
    
    return cell
  }
}

extension MoviesController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 300, height: 300)
  }
}
