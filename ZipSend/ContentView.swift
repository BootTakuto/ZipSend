//
//  ContentView.swift
//  ZipSend
//
//  Created by 青木択斗 on 2025/10/01.
//

import SwiftUI

struct ContentView: View {
    @State var isDispLoading = false
    @State var nowDispPage: PageNames = .appTitle
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.accentBackground
            
            // タイトル画面
            if nowDispPage == .appTitle {
                AppTitle()
            }
            
            // 写真選択画面
            if nowDispPage == .photoSelect {
                PhotoSelectView(isDispLoading: $isDispLoading)
            }
            
            // 画面遷移操作エリア
            if nowDispPage != .appTitle {
                ScreenOperateArea
            }
        }.ignoresSafeArea()
            .overlay {
                if isDispLoading {
                    Loading()
                }
            }
            .onAppear {
                // タイトル表示後、写真選択画面へ
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        nowDispPage = .photoSelect
                    }
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
                
                // 操作画面の最初は次へボタン非表示
                if nowDispPage != .photoSelect {
                    ReturnButton
                }
                Spacer()
                // 操作画面の最後は戻るボタン非表示
                if nowDispPage != .zipSend {
                    NextButton
                }
                    
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
