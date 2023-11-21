import Foundation

class StoryViewModel: ObservableObject {
    let story: Story
    let position: Int
    
    init(_ story: Story, position: Int) {
        self.story = story
        self.position = position
    }
    
    // MARK: Computed properties
    var footnote: String {
        story.url.formatted + " - \(story.date.timeAgo)" + " - by \(story.author)"
    }
}
