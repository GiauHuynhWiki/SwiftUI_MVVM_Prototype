import SwiftUI

struct NewsView: View {
    @StateObject private var vm = NewsViewModel()
    
    var body: some View {
        List(vm.stories.indices, id: \.self) { index in
            StoryView(vm.stories[index], position: index + 1)
        }
        .navigationTitle("News")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: vm.fetchTopStories)
    }
}
