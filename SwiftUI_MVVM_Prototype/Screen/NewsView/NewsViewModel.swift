import Foundation

class NewsViewModel: ObservableObject {
    @Published var stories: [Story] = []
    
    func fetchTopStories() {
        HTTPService.request("https://hacker-news.firebaseio.com/v0/beststories.json").responseDecodable { [weak self] (ids: [Int]?) in
            guard let self = self else { return }
            guard let ids = ids else { return }
            self.stories.removeAll()
            for id in ids {
                fetchStory(id) { story in
                    if let story = story {
                        self.stories.append(story)
                    }
                }
            }
        }
    }
    
    func fetchStory(_ id: Int, completion: @escaping (Story?) -> Void) {
        HTTPService.request("https://hacker-news.firebaseio.com/v0/item/\(id).json")
            .responseDecodable { story in
                completion(story)
            }
    }
}
