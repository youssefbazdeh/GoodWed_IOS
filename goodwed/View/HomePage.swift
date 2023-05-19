import SwiftUI

struct HomePage: View {
    @State private var isAnimating = false
    @State var timeRemaining: TimeInterval = 60 * 60 * 24 * 7 // 7 days in seconds
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let icons = ["house", "car", "star", "bell", "camera"]
    let captions = ["Home", "Drive", "Favorites", "Notifications", "Photos"]
    @StateObject private var viewModel = ProfileViewModel()

    
    
    var body: some View {
        VStack{
            HStack{
         
                Text("Home")
                    .font(.headline)
                    .foregroundColor(.purple)
                   // .offset(x:175,y: 15)
                    .padding(.leading)
               

            }
            .padding(.top)
            .padding(.bottom, 10)
           // .background(Color.white)
            .shadow(color: Color.gray.opacity(0.4), radius: 2, x: 0, y: 2)
            
            ZStack {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 250, height: 150)
                    .foregroundColor(.purple)
                    // animate heart beats
                    .scaleEffect(isAnimating ? 1.0 : 0.8)
                    .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                Text("Omar & Youssef")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .offset(y:2)
                
                Text(timeString(time: timeRemaining))
                    .font(.title3)
                    .foregroundColor(.white)
                    .scaledToFit()
                    .offset(y:-25)
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        }
                    }
                    .onAppear() {
                        timer.upstream.connect().cancel()
                    }
                    .overlay(
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                            .opacity(0.5)
                            .font(.system(size: 15))
                            .offset(x: 3, y: 25)
                    )
            }
            .overlay(
               RoundedRectangle(cornerRadius: 0)
                .stroke(Color.gray, lineWidth: 0)
                .frame(width: 500, height: 220)
                )
            .position(x:200,y:100)
            .onAppear {
                isAnimating = true
            }

            HStack(alignment: .center){
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
            .offset(y:-90)
           
        }
        .onAppear {viewModel.fetchNews()}
      
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
              
            }
            .padding()
           // .background(Color.white)
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

    
    
    func timeString(time: TimeInterval) -> String {
        let days = Int(time) / 86400
        let hours = Int(time) / 3600 % 24
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d:%02d", days, hours, minutes, seconds)
    }
    
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()

    }
}
