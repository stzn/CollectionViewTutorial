import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pageImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(tutorial: Tutorial) {
        
        pageImageView.image = UIImage(named: tutorial.imageName)
        
        let attributedText = NSMutableAttributedString(
            string: tutorial.summary,
            attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText
            .append(NSAttributedString(
                string: "\n\n\n\(tutorial.detail)",
                attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13),
                             NSAttributedStringKey.foregroundColor: UIColor.gray]))
        descriptionTextView.attributedText = attributedText
        descriptionTextView.textAlignment = .center
    }
}
