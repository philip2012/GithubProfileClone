import UIKit

class ViewController: UIViewController {
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    private let noiseLayer: CALayer = CALayer()
    
    private func generateNoiseImage(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let size = CGSize(width: 128, height: 128)

            let renderer = UIGraphicsImageRenderer(size: size)
            let image = renderer.image { context in
                let cgContext = context.cgContext

                for x in 0..<Int(size.width) {
                    for y in 0..<Int(size.height) {
                        let gray = CGFloat.random(in: 0...1)
                        cgContext.setFillColor(UIColor(white: gray, alpha: 0.1).cgColor)
                        cgContext.fill(CGRect(x: x, y: y, width: 1, height: 1))
                    }
                }
            }

            DispatchQueue.main.async {
                completion(image)
            }
        }
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
        
        var config = UIButton.Configuration.filled()
        config.title = "Follow"
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .clear
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        button.configuration = config
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(white: 1.0, alpha: 0.2).cgColor
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
    
    private let followersIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(white: 0.6, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        let attributedText = NSMutableAttributedString(string: "98 ", attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .foregroundColor: UIColor.white
        ])
        attributedText.append(NSAttributedString(string: "followers", attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor(white: 0.6, alpha: 1)
        ]))
        
        label.attributedText = attributedText
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: "38 ", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold), .foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "following", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor: UIColor(white: 0.6, alpha: 1)]))
        
        label.attributedText = attributedText
        return label
    }()
    
    private let statsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private let locationIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "mappin.and.ellipse"))
        imageView.tintColor = UIColor(white: 0.6, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Ho Chi Minh City, Vietnam"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(white: 0.8, alpha: 1)
        return label
    }()
    
    private let locationStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private let navigationView: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Overview", "Repositories", "Starred"])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.tintColor = .clear
        view.selectedSegmentTintColor = UIColor(white: 1, alpha: 0.15)
        view.selectedSegmentIndex = 0
        view.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        let attributedText = [
            NSAttributedString.Key.foregroundColor: UIColor(white: 0.6, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)
        ]
        let selectedText = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold)
        ]
        
        view.setTitleTextAttributes(attributedText, for: .normal)
        view.setTitleTextAttributes(selectedText, for: .selected)
        return view
    }()
    
    private let navigationTrackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 0.04)
        view.layer.cornerRadius = 22
        view.clipsToBounds = true
        return view
    }()
    
    private let tabsContentView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    private func setupMockRepoCard(for repo: Repository, cardColor: UIColor) -> UIView {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = cardColor
        card.layer.cornerRadius = 12
        card.clipsToBounds = true
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = repo.name
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
            
        let subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = repo.description
        subtitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.textColor = UIColor(white: 0.7, alpha: 1)
        subtitleLabel.numberOfLines = 2
            
        let techIndicator = UILabel()
        techIndicator.translatesAutoresizingMaskIntoConstraints = false
        techIndicator.text = "● \(repo.language)"
        techIndicator.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        techIndicator.textColor = repo.languageColor
        
        card.addSubview(titleLabel)
        card.addSubview(subtitleLabel)
        card.addSubview(techIndicator)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 14),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
                
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            
            techIndicator.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 14),
                
            techIndicator.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -14),
            techIndicator.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
        ])
        
        return card
    }
    
    struct Repository {
        let name: String
        let description: String
        let language: String
        let languageColor: UIColor
    }
    
    let mockRepositories = [
        Repository(name: "FlyKit", description: "High-performance flight dynamics engine for JSBSim configurations.", language: "Swift", languageColor: .systemBlue),
        Repository(name: "MetalGrain", description: "Custom MSL shaders for rendering premium procedural noise overlays.", language: "Metal", languageColor: .systemPurple),
        Repository(name: "LuauBridge", description: "Lightweight script bindings and automatic type generation utility.", language: "C++", languageColor: .systemOrange)
    ]
    
    private func renderOverview() {
        if let firstRepo = mockRepositories.first {
            let overviewCard = setupMockRepoCard(for: firstRepo, cardColor: UIColor(white: 1, alpha: 0.05))
            tabsContentView.addArrangedSubview(overviewCard)
        }
    }
    
    private func renderRepositories() {
        mockRepositories.forEach {
            let repoCard = setupMockRepoCard(for: $0, cardColor: UIColor(white: 1.0, alpha: 0.03))
            tabsContentView.addArrangedSubview(repoCard)
        }
    }

    private func renderStarred() {
        if mockRepositories.count > 1 {
            let starredCard = setupMockRepoCard(for: mockRepositories[1], cardColor: UIColor(white: 1, alpha: 0.04))
            tabsContentView.addArrangedSubview(starredCard)
        }
    }
    
    private func setupProfileHeader() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(textStackView)
        contentView.addSubview(followButton)
        contentView.addSubview(bioLabel)
        contentView.addSubview(statsStackView)
        contentView.addSubview(locationStackView)
        contentView.addSubview(navigationTrackView)
        contentView.addSubview(tabsContentView)
        
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(usernameLabel)
        
        statsStackView.addArrangedSubview(followersIcon)
        statsStackView.addArrangedSubview(followersLabel)
        statsStackView.addArrangedSubview(followingLabel)
        
        locationStackView.addArrangedSubview(locationIcon)
        locationStackView.addArrangedSubview(locationLabel)
        
        navigationTrackView.addSubview(navigationView)
        
        NSLayoutConstraint.activate([
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
            followButton.heightAnchor.constraint(equalToConstant: 40),
            
            bioLabel.topAnchor.constraint(equalTo: followButton.bottomAnchor, constant: 20),
            bioLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bioLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            statsStackView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 16),
            statsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            followersIcon.widthAnchor.constraint(equalToConstant: 16),
            followersIcon.heightAnchor.constraint(equalToConstant: 16),
                    
            locationStackView.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 12),
            locationStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            locationIcon.widthAnchor.constraint(equalToConstant: 16),
            locationIcon.heightAnchor.constraint(equalToConstant: 16),
            
            navigationTrackView.topAnchor.constraint(equalTo: locationStackView.bottomAnchor, constant: 24),
            navigationTrackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            navigationTrackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            navigationTrackView.heightAnchor.constraint(equalToConstant: 44),
            
            navigationView.topAnchor.constraint(equalTo: navigationTrackView.topAnchor, constant: 4),
            navigationView.leadingAnchor.constraint(equalTo: navigationTrackView.leadingAnchor, constant: 4),
            navigationView.trailingAnchor.constraint(equalTo: navigationTrackView.trailingAnchor, constant: -4),
            navigationView.bottomAnchor.constraint(equalTo: navigationTrackView.bottomAnchor, constant: -4),
            
            contentView.bottomAnchor.constraint(equalTo: tabsContentView.bottomAnchor, constant: 20),
            
            tabsContentView.topAnchor.constraint(equalTo: navigationTrackView.bottomAnchor, constant: 20),
            tabsContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tabsContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupScrollConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
    }
    
    @objc private func navigationTabChanged(_ sender: UISegmentedControl) {
        UIView.transition(with: self.tabsContentView, duration: 0.2, options: [
            .transitionCrossDissolve,
            .curveEaseInOut
        ], animations: { [weak self] in
            guard let self = self else { return }
            
            self.tabsContentView.arrangedSubviews.forEach {
                self.tabsContentView.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
            
            switch sender.selectedSegmentIndex {
            case 0:
                self.renderOverview()
            case 1:
                self.renderRepositories()
            case 2:
                self.renderStarred()
            default:
                break
            }
        }, completion: nil)
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
        
        generateNoiseImage { [weak self] noiseImage in
            guard let self = self, let image = noiseImage else {
                return
            }

            self.noiseLayer.contents = image.cgImage
            self.noiseLayer.contentsGravity = .resize
        }
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.layer.insertSublayer(noiseLayer, above: gradientLayer)
        
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        setupScrollConstraints()
        setupProfileHeader()
        
        navigationView.addTarget(self, action: #selector(navigationTabChanged(_:)), for: .valueChanged)
        renderOverview()
        
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        gradientLayer.frame = view.bounds
        noiseLayer.frame = view.bounds
    }

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        scrollView.contentInset = UIEdgeInsets(
            top: view.safeAreaInsets.top,
            left: 0,
            bottom: view.safeAreaInsets.bottom,
            right: 0
        )
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        let fadeRange: CGFloat = 150
        let alpha = max(0.0, min(1.0, 1.0 - (offsetY / fadeRange)))
                
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        gradientLayer.opacity = Float(alpha)
        CATransaction.commit()
    }
}
