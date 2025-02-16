import UIKit



final class LoadViewController: UIViewController {
    weak var delegate: LoadViewControllerDelegate?
    
    // MARK: - UI Components
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Constants.Image.logo))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        setupConstraints()
        fetchJokeAndSwitchScreen()
    }
}

// MARK: - Setup Methods
private extension LoadViewController {
    func setupView() {
        view.backgroundColor = .jLaunchScreenGreen
    }
    
    func setupSubviews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func fetchJokeAndSwitchScreen() {
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        delegate = mainVC
        delegate?.fetchJoke(vc: self, isFirstTime: true) {
            self.present(mainVC, animated: true)
        }
    }
}

