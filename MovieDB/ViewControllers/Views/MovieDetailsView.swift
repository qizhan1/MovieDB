// *************************************************************************************************
// - MARK: Imports


import Foundation
import UIKit


// *************************************************************************************************
// - MARK: MovieCell


class MovieDetailsView: UIView {
    
    
    // - MARK: Constants
    
    
    static let identifier = "MovieCellReuseIdentifier"
    let horizontalPadding: CGFloat = 10.0
    let verticalPadding: CGFloat = 4.0
    
    
    // - MARK: Properties
    
    
    var backgroundView: UIView!
    var overviewTextView: UITextView!
    var originalLanguageLabel: UILabel!
    var loadingIndicator: UIActivityIndicatorView!
    var titleLabel: UILabel!
    var photoView: UIImageView!
    var originalTitleLabel: UILabel!
    var releaseDateLabel: UILabel!
    var movie: Movie? {
        didSet {
            self.layoutIfNeeded()
            PosterImageDataProvider.shared.fetchPoster(for: movie, with: .large) { image in
                DispatchQueue.main.async { [weak self] in
                    self?.photoView.image = image
                    self?.setNeedsDisplay()
                }
            }
        }
    }
    
    
    // - MARK: Init
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photoView = UIImageView()
        titleLabel = UILabel()
        originalTitleLabel = UILabel()
        originalLanguageLabel = UILabel()
        releaseDateLabel = UILabel()
        overviewTextView = UITextView()
        loadingIndicator = UIActivityIndicatorView()
        backgroundView = UIView(frame: .zero)
        addSubViews()
        setupLoadingIndicator()
        setupBiographyTextView()
        setupBackgroundView()
        photoView.contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // - MARK: Fileprivate Methods
    
    
    fileprivate func addSubViews() {
        addSubview(backgroundView)
        addSubview(photoView)
        addSubview(titleLabel)
        addSubview(originalTitleLabel)
        addSubview(originalLanguageLabel)
        addSubview(releaseDateLabel)
        addSubview(overviewTextView)
        addSubview(loadingIndicator)
    }
    
    
    fileprivate func setupLoadingIndicator() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .whiteLarge
    }
    
    
    fileprivate func setupBackgroundView() {
        backgroundColor = .black
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        backgroundView.addSubview(blurEffectView)
    }
    
    
    fileprivate func setupBiographyTextView() {
        overviewTextView.isScrollEnabled = false
        overviewTextView.backgroundColor = UIColor.clear
        overviewTextView.isUserInteractionEnabled = false
        overviewTextView.textContainerInset = .zero
        overviewTextView.textContainer.lineFragmentPadding = 0;
    }
    
    
    // - MARK: Overrided Methods
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = bounds.size
        
        photoView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height * ( 2.0 / 3.0))
        photoView.clipsToBounds = true
        
        titleLabel.attributedText = NSAttributedString.attributedString(title: movie?.title)
        originalLanguageLabel.attributedText = NSAttributedString.attributedString(description: movie?.originalLanguageText)
        originalTitleLabel.attributedText = NSAttributedString.attributedString(description: movie?.originalTitleText)
        releaseDateLabel.attributedText = NSAttributedString.attributedString(description: movie?.releaseDateText)
        overviewTextView.attributedText = NSAttributedString.attributedString(description: movie?.overview)
        
        titleLabel.sizeToFit()
        let nameLabelSize = titleLabel.bounds.size
        titleLabel.frame = CGRect(x: horizontalPadding,
                                 y: size.height * (2.0 / 3.0) - nameLabelSize.height,
                                 width: nameLabelSize.width,
                                 height: nameLabelSize.height)
        
        originalTitleLabel.sizeToFit()
        originalTitleLabel.frame = CGRect(x: horizontalPadding,
                                 y: titleLabel.frame.origin.y + titleLabel.frame.size.height + verticalPadding,
                                 width: originalTitleLabel.bounds.width,
                                 height: originalTitleLabel.bounds.height)
        
        releaseDateLabel.sizeToFit()
        releaseDateLabel.frame = CGRect(x: horizontalPadding,
                                 y: originalTitleLabel.frame.origin.y + originalTitleLabel.frame.size.height + verticalPadding,
                                 width: releaseDateLabel.bounds.width,
                                 height: releaseDateLabel.bounds.height)
        
        originalLanguageLabel.sizeToFit()
        originalLanguageLabel.frame = CGRect(x: horizontalPadding,
                                         y: releaseDateLabel.frame.origin.y + releaseDateLabel.frame.size.height + verticalPadding,
                                         width: originalLanguageLabel.bounds.width,
                                         height: originalLanguageLabel.bounds.height)
        
        overviewTextView.frame = CGRect(x: horizontalPadding,
                                         y: originalLanguageLabel.frame.origin.y + originalLanguageLabel.frame.size.height + verticalPadding,
                                         width: size.width - 16,
                                         height: size.height * ( 1.0 / 3.0))
        backgroundView?.frame = bounds
        loadingIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        loadingIndicator.center = center
    }
    
    
}
