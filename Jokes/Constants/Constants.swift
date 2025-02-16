import UIKit

enum Constants {
    enum Font {
        static let regular = UIFont(name: "Roboto-Medium", size: 16)!
        static let large = UIFont(name: "Roboto-Medium", size: 24)!
    }
    
    enum Image {
        static let refresh = "Refresh"
        static let logo = "LaunchScreenLogo"
    }
    
    enum API {
        static let baseURl = "https://official-joke-api.appspot.com/jokes/random"
    }
    
    enum Error {
        static let failedPreparingURL = "Failed to prepare URL"
    }
}
