import UIKit


final class WhiteView: UIView {
    private var leftLabel: UILabel?
    private var rightLabel: UILabel?
    
    init(leftLabel: UILabel, rightLabel: UILabel, height: CGFloat = 64) {
        super.init(frame: .zero)
        self.leftLabel = leftLabel
        self.rightLabel = rightLabel
        setupUI(height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WhiteView {
    func setupUI(height: CGFloat) {
        setupView()
        setupSubviews(viewHeight: height)
    }
    
    func setupView() {
        self.backgroundColor = .jWhite
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.jBlack.cgColor
    }
    
    func setupSubviews(viewHeight: CGFloat) {
        guard let leftLabel,let rightLabel else { return }
        
        [leftLabel, rightLabel].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subview)
        }
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: viewHeight),
            leftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            leftLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            rightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
