import Foundation
import Alamofire

struct URLPaths {
    static let movieList: String = "/discover/movie"
}

class Networking {
    
    // MARK: - Properties
    
    static let shared = Networking()
    
    private let baseURL: String = "https://api.themoviedb.org/3"
    private let apiKey: String = "9a9ccedad120c36bc679bbe5e74fe6a6"
    private let language: String = "ru"
    private lazy var parameters: [String: String] = [
        "api_key": self.apiKey,
        "language": self.language
    ]
    
    // MARK: - Functions
    
    private func getUrlWith(url: String, path: String, params: [String: String]? = nil) -> URL? {
        guard var components = URLComponents(string: url + path) else { return nil }
        if let params = params {
            components.queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
        }
        return components.url
    }
    
    func getMovies(page: Int,
                   okHandler: @escaping ([Movie]) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        self.parameters["page"] = String(page)
        
        guard let url = getUrlWith(url: baseURL, path: URLPaths.movieList, params: parameters) else {
            return
        }
        AF.request(url).responseDecodable(of: Response.self) { (response) in
            switch response.result {
            case let .success(value):
                okHandler(value.results)
            case let .failure(error):
                errorHandler(error)
            }
        }
    }
}
