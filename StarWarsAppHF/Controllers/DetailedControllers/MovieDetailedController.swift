import UIKit

class MovieDetailedController: UIViewController {
  
  public var movieCrawl: String?
  public var movie: StarWarsMovie!
  
  @IBOutlet weak var moviePoster: UIImageView!
  @IBOutlet weak var movieDescription: UITextView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setDetailedView()
  }
  
  func setDetailedView() {
    
  }
 
}
