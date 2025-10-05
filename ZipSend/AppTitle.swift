//
//  AppOpening.swift
//  ZipSend
//
//  Created by 青木択斗 on 2025/10/05.
//

import SwiftUI

/// オープニング画面
struct AppTitle: View {
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.accentBackground
                
                VStack(spacing: 5) {
                    
                    icon
                        .offset(x: -15)
                    Text("Zip Sender")
                        .font(.title)
                        .fontWeight(.heavy)
                }
            } .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    var icon: some View {
        ZStack {
            Image(systemName: "arrowshape.forward.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .offset(x: 55, y: 10)
            Image(systemName: "document")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .padding(3)
                .background {
                    Color.accentBackground
                }
            RoundedRectangle (cornerRadius: 5)
                .frame(width: 50, height: 25)
                .overlay {
                    Text("Zip")
                        .font(.system(size: 12))
                        .fontWeight(.bold)
                        .foregroundStyle(.windowBackground)
                }
                .padding(5)
                .border(.accentBackground, width: 5)
                .offset(x: -25, y: 10)
        }
    }
}

#Preview {
    AppTitle()
}
