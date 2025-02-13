import UIKit


final class JokeView: UIView {
    // MARK: - UI Components
    private lazy var setupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .jBlack
        label.font = Constants.Font.regular
        label.text = "Setup"
        return label
    }()
    
    private lazy var topLine = createBlackLine()
    private lazy var bottomLine = createBlackLine()
    
    private var jokeLabel: UILabel?
    
    private lazy var jokeView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Init
    init(jokeLabel: UILabel) {
        super.init(frame: .zero)
        self.jokeLabel = jokeLabel
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Methods
private extension JokeView {
    func setup() {
        self.backgroundColor = .jPink
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 2
        setupSubviews()
        setupJokeLabel()
    }
    
    func setupSubviews() {
        [setupLabel, topLine, jokeView, bottomLine].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.addSubview(jokeView)
        self.addSubview(setupLabel)
        jokeView.addSubview(topLine)
        jokeView.addSubview(bottomLine)
        
        NSLayoutConstraint.activate([
            setupLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            setupLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            jokeView.topAnchor.constraint(equalTo: setupLabel.bottomAnchor, constant: 18),
            jokeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            jokeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            jokeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            topLine.heightAnchor.constraint(equalToConstant: 2),
            topLine.leadingAnchor.constraint(equalTo: jokeView.leadingAnchor),
            topLine.trailingAnchor.constraint(equalTo: jokeView.trailingAnchor),
            topLine.topAnchor.constraint(equalTo: jokeView.topAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 2),
            bottomLine.bottomAnchor.constraint(equalTo: jokeView.bottomAnchor),
            bottomLine.leadingAnchor.constraint(equalTo: jokeView.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: jokeView.trailingAnchor)
        ])
    }
    
    func setupJokeLabel() {
        guard let jokeLabel else { return }
        
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        jokeLabel.font = Constants.Font.large
        jokeLabel.textColor = .jBlack
        jokeLabel.numberOfLines = 0
        jokeLabel.textAlignment = .center
        
        jokeView.addSubview(jokeLabel)
        
        NSLayoutConstraint.activate([
            jokeLabel.topAnchor.constraint(equalTo: jokeView.centerYAnchor),
            jokeLabel.leadingAnchor.constraint(equalTo: jokeView.leadingAnchor),
            jokeLabel.trailingAnchor.constraint(equalTo: jokeView.trailingAnchor)
        ])
    }

    
    func createBlackLine() -> UIView {
        let line = UIView()
        line.backgroundColor = .jBlack
        return line
    }
}
