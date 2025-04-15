import Foundation

struct Story: Identifiable, Decodable {
    let id: String
    let body: String
    let author: String
    let image: StoryImage
}

struct StoryImage: Decodable {
    let url: String
    let width: Int
    let height: Int
}
