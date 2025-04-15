import Foundation
import Combine

class StoryViewModel: ObservableObject {
    @Published var stories: [Story] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var currentPageId: String? = "2"
    private var cancellables = Set<AnyCancellable>()
    private let storyService: StoryServiceProtocol
    
    init(storyService: StoryServiceProtocol = StoryService()) {
        self.storyService = storyService
        loadMoreContent()
    }
    
    func loadMoreContent() {
        guard !isLoading, currentPageId != nil else { return }
        
        isLoading = true
        
        storyService.fetchStories(pageId: currentPageId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] page in
                self?.stories.append(contentsOf: page.stories)
                self?.currentPageId = page.nextPageId
            })
            .store(in: &cancellables)
    }
}
