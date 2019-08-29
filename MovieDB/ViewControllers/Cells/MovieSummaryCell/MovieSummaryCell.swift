// *************************************************************************************************
// - MARK: MovieSummaryCell


import UIKit


// *************************************************************************************************
// - MARK: MovieSummaryCell


class MovieSummaryCell: UITableViewCell {

    
    // - MARK: Reuse Identifier
    
    
    static let identifier = "MovieSummaryCellReuseIdentifier"
    
    
    // - MARK: Properties
    
    
    var movie: Movie? {
        didSet {
            title.attributedText = NSAttributedString.attributedString(description: movie?.title)
            releaseDate.attributedText = NSAttributedString.attributedString(description: movie?.releaseDate)            
            PosterImageDataProvider.shared.fetchPoster(for: movie, with: .small) { image in
                DispatchQueue.main.async { [weak self] in
                    self?.poster.image = image
                    self?.setNeedsDisplay()
                }
            }
        }
    }
    
    
    // - MARK: IBOutlets
    
    
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    
    // - MARK: Overrides
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.lightGray
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        poster.image = nil
    }
    
    
}
