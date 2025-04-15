import SwiftUI

struct CachedAsyncImage<Content: View>: View {
    private let url: String
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(
        url: String,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        if let url = URL(string: url) {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                content(phase)
            }
        } else {
            content(.empty)
        }
    }
}
