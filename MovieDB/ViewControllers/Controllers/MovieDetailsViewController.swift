// *************************************************************************************************
// - MARK: Imports


import UIKit


// *************************************************************************************************
// - MARK: MovieDetailsViewController


class MovieDetailsViewController: UIViewController {
    
    
    var movie: Movie?
    
    
    override func loadView() {
        self.view = MovieDetailsView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        if let movieView = view as? MovieDetailsView {
            movieView.movie = movie
        }
    }
    
    
}
