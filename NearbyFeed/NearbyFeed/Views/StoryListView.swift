import SwiftUI

struct StoryListView: View {
    @StateObject private var viewModel = StoryViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.stories) { story in
                    StoryView(story: story)
                        .onAppear {
                            if story.id == viewModel.stories.last?.id {
                                viewModel.loadMoreContent()
                            }
                        }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Nearby Stories")
            .alert(isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
