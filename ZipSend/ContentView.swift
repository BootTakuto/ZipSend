//
//  ContentView.swift
//  ZipSend
//
//  Created by 青木択斗 on 2025/10/01.
//

import SwiftUI

struct ContentView: View {
    @State var nowStep = 0
    @State var isDispLoading = false
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.accentBackground
            PhotoSelectView(isDispLoading: $isDispLoading)
            ScreenOperateArea
        }.ignoresSafeArea()
            .overlay {
                if isDispLoading {
                    Loading()
                }
            }
    }
    
    ///  画面操作エリア（構成要素：次へボタン、戻るボタン）
    @ViewBuilder
    var ScreenOperateArea: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.mainBackground)
                .frame(height: 100)
                .shadow(color: .customShadow, radius: 5)
            HStack {
                ReturnButton
                Spacer()
                NextButton
            }.padding(.horizontal, 25)
        }
        
    }
    
    /// 次へボタン
    @ViewBuilder
    var NextButton: some View {
        Button(action: {
            
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 100, height: 50)
                    .foregroundStyle(.cusotomPrimary)
                Text("次へ")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
        }
    }
    
    /// 戻るボタン
    @ViewBuilder
    var ReturnButton: some View {
        Button(action: {
            
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 100, height: 50)
                    .foregroundStyle(.customDanger)
                Text("戻る")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    ContentView()
}
