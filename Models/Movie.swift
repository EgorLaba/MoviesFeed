
import Foundation

struct Movie: Decodable {
    var adult: Bool
    var genre_ids: [Int]
    var id: Int
    var title: String
    var poster_path: String?
    var popularity: Double
    var release_date: String?
    var vote_average: Double
    var vote_count: Int
}

