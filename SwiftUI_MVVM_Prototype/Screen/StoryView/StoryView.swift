import SwiftUI

struct StoryView: View {
    @StateObject private var vm: StoryViewModel
    
    init(_ story: Story, position: Int) {
        let vm = StoryViewModel(story, position: position)
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16.0) {
            position
            VStack(alignment: .leading, spacing: 8.0) {
                Text(vm.story.title)
                    .font(.headline)
                Text(vm.footnote)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    badge(text: vm.story.score.formatted, imageName: "arrowtriangle.up.circle")
                        .foregroundColor(.teal)
                    badge(text: vm.story.commentCount.formatted, imageName: "ellipses.bubble")
                        .padding(.leading, 96.0)
                        .foregroundColor(.orange)
                }
                .font(.callout)
                .padding(.bottom)
            }
        }
        .padding(.top, 16.0)
    }
    
    // MARK: UI Components
    private var position: some View {
        ZStack {
            Circle()
                .frame(width: 32.0, height: 32.0)
                .foregroundColor(.teal)
            Text("\(vm.position)")
                .font(.callout)
                .bold()
                .foregroundColor(.white)
        }
    }
    
    private func badge(text: String, imageName: String) -> some View {
        HStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
}
