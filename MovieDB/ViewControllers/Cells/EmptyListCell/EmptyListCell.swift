// *************************************************************************************************
// - MARK: Imports


import Foundation
import UIKit


// *************************************************************************************************
// - MARK: EmptyListCell


class EmptyListCell: UITableViewCell {
    
    
    // - MARK: Constants
    
    
    static let identifier = "EmptyListCellReuseIdentifier"
    
    
    // - MARK: Properties
    
    
    var emptyListLabel: UILabel!
    
    
    // - MARK: Init
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        emptyListLabel = UILabel()
        addSubview(emptyListLabel)
        self.backgroundColor = UIColor.lightGray
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // - MARK: Overrided Methods
    
    
    override func layoutSubviews() {
        emptyListLabel.attributedText = NSAttributedString.attributedString(title: "No Result")
        emptyListLabel.sizeToFit()
        emptyListLabel.center = center
    }
    
    
}
