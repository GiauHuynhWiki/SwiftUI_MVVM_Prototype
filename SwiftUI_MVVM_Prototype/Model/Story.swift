import Foundation

struct Story: Identifiable {
    let id: Int
    let commentCount: Int
    let score: Int
    let author: String
    let title: String
    let date: Date
    let url: URL
}

extension Story: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, score, title, url
        case commentCount = "descendants"
        case date = "time"
        case author = "by"
    }
}
