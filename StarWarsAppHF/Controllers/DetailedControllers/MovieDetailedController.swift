import UIKit

class MovieDetailedController: UIViewController {
  
  var currentMovie: StarWarsMovie!
  
  @IBOutlet weak var moviePoster: UIImageView!
  @IBOutlet weak var movieDescription: UITextView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setDetailedView()
  }
  
  func setDetailedView() {
    if let movie = currentMovie {
     movieDescription.text = movie.director
    }
  }
}
