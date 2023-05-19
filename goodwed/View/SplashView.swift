//
//  SplashView.swift
//  goodwed
//
//  Created by omarKaabi on 10/5/2023.
//

import SwiftUI

struct ProgressBar: View {
    let progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray)
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width * CGFloat(min(self.progress, 1)))
                    .animation(.linear)
            }
            .frame(height: 8)
        }
    }
}

struct SplashView: View {
    @State var isActive: Bool = false
    @State var logoOpacity: Double = 0.0
    @State var progress: Double = 0.0
    
    var body: some View {
        ZStack{
            if self.isActive{
                ContentView()
            } else {
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0.5411764979, green: 0.2784313858, blue: 0.9215686321, alpha: 1)))
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .opacity(self.logoOpacity)
                        .padding(.bottom, -90)
                    
                    ProgressBar(progress: self.progress)
                        .frame(height: 8)
                        .padding(.horizontal, 100) // Adjust the horizontal padding
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(.white)
            }
        }
        .onAppear{
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                self.logoOpacity += 0.1/3.0
                self.progress += 0.1/3.0
                if self.logoOpacity >= 1 {
                    timer.invalidate()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}


struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
