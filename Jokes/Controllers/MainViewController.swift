import UIKit


protocol LoadViewControllerDelegate: AnyObject {
    func fetchJoke(vc: LoadViewController?, isFirstTime: Bool, completion: (() -> Void)?)
}

final class MainViewController: UIViewController {
    
    // MARK: - UI Components
    private lazy var jokeIdLabel = createLabel(text: "Joke ID")
    private lazy var numberOfJokeIdLabel = createLabel(text: "265")
    private lazy var typeLabel = createLabel(text: "Type")
    private lazy var textOfTypeLabel = createLabel(text: "general")
    
    private lazy var jokeIdView = WhiteView(leftLabel: jokeIdLabel, rightLabel: numberOfJokeIdLabel)
    private lazy var typeView = WhiteView(leftLabel: typeLabel, rightLabel: textOfTypeLabel)
    
    private lazy var jokeLabel: UILabel = {
        let label = UILabel()
        label.text = "Why did the chicken get a penalty?"
        return label
    }()
    
    private lazy var jokeView = JokeView(jokeLabel: jokeLabel)
    
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Constants.Image.refresh), for: .normal)
        button.tintColor = .jBlack
        button.backgroundColor = .jWhite
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.addAction(UIAction { [weak self] _ in
            self?.switchJoke()
        }, for: .primaryActionTriggered)
        return button
    }()
    
    private lazy var showButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show punchline", for: .normal)
        button.setTitleColor(.jBlack, for: .normal)
        button.backgroundColor = .jGreen
        button.titleLabel?.font = Constants.Font.regular
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.addAction(UIAction { [weak self] _ in
            self?.showAlert()
        }, for: .primaryActionTriggered)
        return button
    }()
    
    // MARK: - Properties
    private let jokesLoader = JokesLoader.shared
    private var joke: Joke?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        setupConstraints()
    }
}

// MARK: - Setup Methods
private extension MainViewController {
    func setupView() {
        view.backgroundColor = .jGrey
    }
    
    func setupSubviews() {
        [jokeIdView, typeView, refreshButton, showButton, jokeView].forEach{ subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            jokeIdView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            jokeIdView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            jokeIdView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            typeView.topAnchor.constraint(equalTo: jokeIdView.bottomAnchor, constant: 24),
            typeView.leadingAnchor.constraint(equalTo: jokeIdView.leadingAnchor),
            typeView.trailingAnchor.constraint(equalTo: jokeIdView.trailingAnchor),
            jokeView.topAnchor.constraint(equalTo: typeView.bottomAnchor, constant: 24),
            jokeView.leadingAnchor.constraint(equalTo: typeView.leadingAnchor),
            jokeView.trailingAnchor.constraint(equalTo: typeView.trailingAnchor),
            refreshButton.heightAnchor.constraint(equalToConstant: 64),
            refreshButton.widthAnchor.constraint(equalTo: refreshButton.heightAnchor),
            refreshButton.topAnchor.constraint(equalTo: jokeView.bottomAnchor, constant: 55),
            refreshButton.leadingAnchor.constraint(equalTo: jokeView.leadingAnchor),
            refreshButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64),
            showButton.leadingAnchor.constraint(equalTo: refreshButton.trailingAnchor, constant: 16),
            showButton.trailingAnchor.constraint(equalTo: jokeView.trailingAnchor),
            showButton.topAnchor.constraint(equalTo: refreshButton.topAnchor),
            showButton.bottomAnchor.constraint(equalTo: refreshButton.bottomAnchor)
        ])
    }
}

// MARK: - Private Methods
private extension MainViewController {
    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .jBlack
        label.font = Constants.Font.regular
        label.text = text
        return label
    }
    
    func updateUI() {
        numberOfJokeIdLabel.text = joke?.id.description
        textOfTypeLabel.text = joke?.type
        jokeLabel.text = joke?.setup
    }
    
    func switchJoke() {
        fetchJoke()
        jokeLabel.text = joke?.setup
    }
    
    func showAlert() {
        AlertPresenter.presentAlert(
            on: self,
            title: "Punchline",
            message: joke?.punchline ?? "Ooops, something went wrong") { [weak self] in
                self?.switchJoke()
            }
    }
}

// MARK: - LoadViewControllerDelegate
extension MainViewController: LoadViewControllerDelegate {
    func fetchJoke(vc: LoadViewController? = nil, isFirstTime: Bool = false, completion: (() -> Void)? = nil) {
        jokesLoader.fetch { [weak self] result in
            switch result {
            case .success(let joke):
                self?.joke = joke
                self?.updateUI()
                if isFirstTime {
                    vc?.dismiss(animated: true) {
                        completion?()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
