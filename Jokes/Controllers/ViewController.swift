import UIKit

final class ViewController: UIViewController {
    // MARK: - UI Components
    private lazy var jokeIdLabel = createLabel(text: "Joke ID")
    private lazy var numberOfJokeIdLabel = createLabel(text: "265")
    
    private lazy var typeLabel = createLabel(text: "Type")
    private lazy var textOfTypeLabel = createLabel(text: "general")
    
    private lazy var jokeIdView = WhiteView(leftLabel: jokeIdLabel, rightLabel: numberOfJokeIdLabel)
    private lazy var typeView = WhiteView(leftLabel: typeLabel, rightLabel: textOfTypeLabel)
    
    private lazy var setupLabel = createLabel(text: "Setup")
    
    private lazy var jokeView: UIView = {
        let view = UIView()
        view.backgroundColor = .jPink
        return view
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.Image.refresh), for: .normal)
        return button
    }()
    
    private lazy var showButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .jGreen
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        setupConstraints()
    }
}

// MARK: - Setup Methods
private extension ViewController {
    func setupView() {
        view.backgroundColor = .jGrey
    }
    
    func setupSubviews() {
        [jokeIdView, typeView, refreshButton, showButton].forEach{ subview in
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
            typeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            typeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }
}

private extension ViewController {
    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = .jBlack
        label.font = Constants.Font.regular
        label.text = text
        return label
    }
}
