
import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let newsList = viewModel.newsList {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(newsList) { news in
                                NewsCardView(news: news)
                            }
                        }
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("News")
        }
        .onAppear {
            viewModel.fetchNews()
        }
    }
}

struct NewsCardView: View {
    let news: news
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(news.title)
                .font(.headline)
            Text(news.content_text)
                .foregroundColor(.secondary)
            if let imageURL = URL(string: news.image) {
                RemoteImage(url: imageURL)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 150)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 150)
            }
            Text(news.date_published)
                .font(.body)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}


struct RemoteImage: View {
    let url: URL
    
    var body: some View {
        Group {
            if let imageData = try? Data(contentsOf: url),
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Image(systemName: "photo")
            }
        }
    }
}


struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
    }
}
