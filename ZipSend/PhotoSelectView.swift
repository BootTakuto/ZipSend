//
//  PhotoSelectView.swift
//  ZipSend
//
//  Created by 青木択斗 on 2025/10/01.
//

import SwiftUI
import PhotosUI

/// 写真選択画面
struct PhotoSelectView: View {
    
    @Binding var isDispLoading: Bool
    
    @State private var selectItems: [PhotosPickerItem] = []
    @State public var selectPhotos: [Image] = []
    @State private var chunkedPhotos: [[Image]] = []
    let MAX_SELECT_CNT: Int = 99999
    let PHOTO_CHUNKED_SIZE: Int = 3
    
    var body: some View {
        GeometryReader { proxy in
            let screenSize = proxy.size
            VStack(spacing: 10) {
                
                Spacer()
                    .frame(height: screenSize.height * 0.075)
                StepMessageArea()
                    .frame(height: screenSize.height * 0.075)
                ActionArea()
                    .frame(height: screenSize.height * 0.85 - 20)
                
            }.frame(width: screenSize.width, height: screenSize.height)
                .overlay {
                    if !selectItems.isEmpty {
                        SelectPhotoCntDispArea()
                            .position(x: screenSize.width / 2, y: screenSize.height - 140)
                        SelectPhotoCircleButton()
                            .position(x: screenSize.width / 2 + 95, y: screenSize.height - 140)
                    }
                }
        }.ignoresSafeArea()
        .onChange(of: selectItems) { oldValue, newValue in
            isDispLoading = true
            // 古いデータを消去
            selectPhotos.removeAll()
            // 別タスクでImageをロードし、画面表示用の2次元配列に変換
            Task {
                for item in newValue {
                    if let loaded = try? await item.loadTransferable(type: Image.self) {
                        selectPhotos.append(loaded)
                        print(selectPhotos.count)
                    }
                }
                // 3つずつに分割した2次元配列にImageを格納
                chunkedPhotos = selectPhotos.chunked(into: PHOTO_CHUNKED_SIZE)
                
                isDispLoading = false
            }
        }
    }
    
    /// Step1のタイトルと説明を表示するエリア
    @ViewBuilder
    func StepMessageArea() -> some View {
        let labelMessage = LabelMessage()
        let title = labelMessage.step1Title
        let message = labelMessage.step1Explain
        VStack (alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            Text(message)
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 25)
    }
    
    /// 操作エリア（写真一覧表示、写真選択ピッカー起動）
    @ViewBuilder
    func ActionArea() -> some View {
        ZStack {
            UnevenRoundedRectangle(topLeadingRadius: 10, topTrailingRadius: 10)
                .foregroundStyle(.mainBackground)
            if selectItems.isEmpty {
                SelectPhotoButton()
                    .offset(y: -50)
            } else {
                SelectPhotoList()
            }
            
        }
    }
    
    /// 写真選択ピッカーボタン　ノーマル
    @ViewBuilder
    func SelectPhotoButton() -> some View {
        PhotosPicker(selection: $selectItems,
                     maxSelectionCount: MAX_SELECT_CNT,
                     matching: .images){
            VStack {
                Image(systemName: "photo.badge.plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                Text("写真を選択")
            }
        }
    }
    
    /// 選択中の写真件数表示エリア
    @ViewBuilder
    func SelectPhotoCntDispArea() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: 120, height: 50)
                .foregroundStyle(.mainBackground)
                .opacity(50)
                .shadow(color: .shadow, radius: 5)
            Text("選択 \(selectPhotos.count) 件")
                .font(.system(size: 15))
        }
    }
    
    /// 写真選択ピッカーボタン　サークル
    @ViewBuilder
    func SelectPhotoCircleButton() -> some View {
        PhotosPicker(selection: $selectItems,
                     maxSelectionCount: MAX_SELECT_CNT,
                     matching: .images) {
            ZStack {
                Circle()
                    .frame(width: 50)
                    .foregroundStyle(.primary)
                    .shadow(color: .shadow, radius: 5)
                VStack(spacing: 0) {
                    Image(systemName: "photo.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                    Text("写真を選択")
                }.foregroundStyle(.white)
                    .font(.system(size: 8))
            }
                
        }
    }
    
    // 写真一覧表示
    @ViewBuilder
    func SelectPhotoList() -> some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 5) {
                    let size = proxy.size
                    ForEach(chunkedPhotos.indices, id: \.self) { row in
                        HStack(spacing: 5) {
                            ForEach(Array(0 ..< PHOTO_CHUNKED_SIZE), id: \.self) { col in
                                let photoSize = (size.width - 5 * 2) / 3
                                
                                // 選択した画像が1列3枚未満の場合は、空白を挿入
                                if chunkedPhotos[row].count > col {
                                    chunkedPhotos[row][col]
                                        .resizable()
                                        .frame(width: photoSize, height: photoSize)
                                        .scaledToFill()
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .transition(.slide)
                                } else {
                                    Spacer()
                                        .frame(width: photoSize, height: photoSize)
                                }
                                
                            }
                        }
                    }
                }
            }
        }.clipShape(UnevenRoundedRectangle(topLeadingRadius: 10, topTrailingRadius: 10))
            .padding(5)
    }
}

#Preview {
    ContentView()
}
