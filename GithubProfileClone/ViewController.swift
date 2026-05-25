import UIKit

class ViewController: UIViewController {
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    private let noiseLayer: CALayer = CALayer()
    
    private func generateNoiseImage() -> UIImage? {
        let size = CGSize(width: 128, height: 128)
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        for x in 0..<Int(size.width) {
            for y in 0..<Int(size.height) {
                let gray = CGFloat.random(in: 0...1)
                context.setFillColor(UIColor(white: gray, alpha: 0.1).cgColor)
                context.fill(CGRect(x: x, y: y, width: 1, height: 1))
            }
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(white: 0.15, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor(white: 1.0, alpha: 0.15).cgColor
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Philips Nguyen"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "philip2012"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(white: 0.6, alpha: 1)
        return label
    }()
    
    private let textStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        return stack
    }()
    
    private let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Modern UIButton Configuration (Bypasses deprecated contentEdgeInsets)
        var config = UIButton.Configuration.filled()
        config.title = "Follow"
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .clear
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        button.configuration = config
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(white: 1.0, alpha: 0.2).cgColor // Subtly blended border
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Building premium iOS architectures. Crafting minimal, high-end interfaces."
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(white: 0.9, alpha: 1)
        return label
    }()
    
    private func setupProfileHeader() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(textStackView)
        contentView.addSubview(followButton)
        contentView.addSubview(bioLabel)
        
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            // Pinned cleanly to topLayoutGuide spacing
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            textStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            textStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            followButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            followButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            followButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            followButton.heightAnchor.constraint(equalToConstant: 40), // Hard-locked standard height
            
            bioLabel.topAnchor.constraint(equalTo: followButton.bottomAnchor, constant: 20),
            bioLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bioLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupScrollConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // FIXED: Scroll view bleeds edge-to-edge beautifully
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content view aligns along the safe frame guides internally
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.05, alpha: 1)
        
        gradientLayer.type = .radial
        gradientLayer.colors = [
            UIColor.systemBlue.withAlphaComponent(0.2).cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.2)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        noiseLayer.opacity = 0.03
        if let noiseImage = generateNoiseImage() {
            noiseLayer.backgroundColor = UIColor(patternImage: noiseImage).cgColor
        }
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.layer.insertSublayer(noiseLayer, above: gradientLayer)
        
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        setupScrollConstraints()
        setupProfileHeader()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
        noiseLayer.frame = view.bounds
        
        // Pushes content offset down so things don't slide under the status bar initially
        scrollView.contentInset = UIEdgeInsets(top: view.safeAreaInsets.top, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }
}
