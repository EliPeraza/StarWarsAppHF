import UIKit

class MovieDetailedController: UIViewController {
  
  public var movieCrawl: String?
  
  @IBOutlet weak var moviePoster: UIImageView!
  @IBOutlet weak var movieDescription: UITextView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setDetailedView()
  }
  
  func setDetailedView() {
 
  }
 
}
