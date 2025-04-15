import Foundation
import Combine

protocol StoryServiceProtocol {
    func fetchStories(pageId: String?) -> AnyPublisher<Page, Error>
}

class StoryService: StoryServiceProtocol {
    private let baseURL = "https://andrewmunn.github.io/newsfeed"
    
    func fetchStories(pageId: String? = "2") -> AnyPublisher<Page, Error> {
        let pageIdToFetch = pageId ?? "2"
        let url = URL(string: "\(baseURL)/page\(pageIdToFetch).json")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Page.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
