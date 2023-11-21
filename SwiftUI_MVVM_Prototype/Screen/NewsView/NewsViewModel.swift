import Foundation

class NewsViewModel: ObservableObject {
    @Published var stories: [Story] = []
    
    func fetchTopStories() {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/beststories.json") else { return }
        let request = APIRequest(url: url)
        request.perform { [weak self] (ids: [Int]?) -> Void in
            guard let self = self else { return }
            guard let ids = ids else { return }
            self.stories.removeAll()
            for id in ids {
                self.fetchStory(withID: id) { story in
                    if let story = story {
                        self.stories.append(story)
                    }
                }
            }
        }
    }
    
    func fetchStory(withID id: Int, completion: @escaping (Story?) -> Void) {
        let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")!
        let request = APIRequest(url: url)
        request.perform(with: completion)
    }
}
