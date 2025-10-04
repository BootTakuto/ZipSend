//
//  ArrayExtention.swift
//  ZipSend
//
//  Created by 青木択斗 on 2025/10/04.
//

import Foundation

extension Array {
    
    /// 1時配列を指定要素数ごとに分割した2次元配列に変更
    /// - Parameters:
    ///  - size:分割サイズ
    /// - Returns: 変換した2次元配列
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
