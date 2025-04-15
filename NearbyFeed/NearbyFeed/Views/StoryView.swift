import SwiftUI

struct StoryView: View {
    let story: Story
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(story.author)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(story.body)
                .font(.body)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
            
            CachedAsyncImage(url: story.image.url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: UIScreen.main.bounds.width - 32, height: 200)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 200)
                        .clipped()
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 200)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            
            Divider()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}
