import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var tutorial: Tutorial? = nil {
        
        didSet {
            
            guard let tutorial = tutorial else {
                return
            }
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
    
    let pageImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        textView.text = "aaaaa"
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        
        let containerView = UIView()
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
            ])
        
        containerView.addSubview(pageImageView)

        NSLayoutConstraint.activate([
            pageImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            pageImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            pageImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5)
            ])
        

        addSubview(descriptionTextView)
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: pageImageView.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            ])
        
    }
}
