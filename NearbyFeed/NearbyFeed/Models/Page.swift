import Foundation

struct Page: Decodable {
    let nextPageId: String?
    let stories: [Story]
}
