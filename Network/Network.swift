import Foundation

struct URLPaths {
    static let fullWeather: String = "/onecall"
}

class Networking {
    
    // MARK: - Properties
    
    static let shared = Networking()
    
    private lazy var session = URLSession(configuration: .default)
    private let baseURL: String = "https://api.openweathermap.org/data/2.5"
    private let appid: String = "6ff3fb460d0433db2333415a383c5733"
    private let units: String = "metric"
    private lazy var parameters: [String: String] = [
        "appid": self.appid,
        "units": self.units
    ]
    
    // MARK: - Functions
    
    func getUrlWith(url: String, path: String, params: [String: String]? = nil) -> URL? {
        guard var components = URLComponents(string: url + path) else { return nil }
        if let params = params {
            components.queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
        }
        return components.url
    }
}
