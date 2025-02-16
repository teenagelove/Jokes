import Foundation

// MARK: - NetworkError
private enum NetworkError: Error {
    case codeError
}

final class NetworkClient {
    // MARK: - Singleton
    static let shared = NetworkClient()
    
    // MARK: - Properties
    private var task: URLSessionTask?
    
    // MARK: - Initializer
    private init() {}
    
    func fetch(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        task?.cancel()
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error {
                completion(.failure(error))
            }
            
            if let
                response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                completion(.failure(NetworkError.codeError))
            }
            
            if let data {
                completion(.success(data))
            }
            
            self?.task = nil
        }
        
        self.task = task
        task.resume()
    }
}
