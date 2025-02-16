import Foundation


final class JokesLoader {
    // MARK: - Singleton
    static let shared = JokesLoader()
    
    // MARK: - Properties
    private var networkClient = NetworkClient.shared
    private var url: URL {
        guard let url = URL(string: Constants.API.baseURl) else {
            preconditionFailure(Constants.Error.failedPreparingURL)
        }
        return url
    }
    
    // MARK: - Initializer
    private init() {}
    
    func fetch(completion: @escaping (Result<Joke, Error>) -> Void) {
        let fulfillOnMainQueue: (Result<Joke, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        networkClient.fetch(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let joke = try JSONDecoder().decode(Joke.self, from: data)
                    fulfillOnMainQueue(.success(joke))
                } catch {
                    fulfillOnMainQueue(.failure(error))
                }
            case .failure(let error):
                fulfillOnMainQueue(.failure(error))
            }
        }
    }
}
