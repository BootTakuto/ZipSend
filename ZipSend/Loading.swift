//
//  CustomProcessView.swift
//  ZipSend
//
//  Created by 青木択斗 on 2025/10/04.
//

import SwiftUI

///  ローディング画面
struct Loading: View {
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.mainBackground)
                .opacity(0.5)
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 120, height: 120)
                .foregroundStyle(.mainBackground)
                .shadow(color: .customShadow, radius: 5)
            VStack(spacing: 15) {
                ProgressView()
                    .scaleEffect(1.5)
                Text("Laoding...")
                    .foregroundStyle(.gray)
                    .font(.system(size: 15))
            }
        }
    }
}

#Preview {
    Loading()
}
