import UIKit


final class AlertPresenter {
    // MARK: - Initializer
    private init() {}
    
    // MARK: - Methods
    static func presentAlert(on viewController: UIViewController, title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        })
        viewController.present(alert, animated: true)
    }
}
