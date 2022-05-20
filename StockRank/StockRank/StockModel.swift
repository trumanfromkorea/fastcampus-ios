//
//  StockModel.swift
//  StockRank
//
//  Created by joonwon lee on 2022/04/19.
//

import Foundation

struct StockModel {
    let rank: Int
    let imageName: String
    let name: String
    let price: Int
    let diff: Double
}

extension StockModel {
    static let list: [StockModel] = [
        StockModel(rank: 1, imageName: "TSLA", name: "테슬라", price: 1238631, diff: 0.04),
        StockModel(rank: 2, imageName: "AAPL", name: "애플", price: 238631, diff: 1.04),
        StockModel(rank: 3, imageName: "NFLX", name: "넷플릭스", price: 438631, diff: -0.04),
        StockModel(rank: 4, imageName: "GOOG", name: "구글", price: 3176631, diff: 0.04),
        StockModel(rank: 5, imageName: "AMZN", name: "아마존", price: 3538631, diff: 0.04),
        StockModel(rank: 6, imageName: "NIKE", name: "나이키", price: 158631, diff: 0.04),
        StockModel(rank: 7, imageName: "DIS", name: "디즈니", price: 138631, diff: 0.04),
        StockModel(rank: 8, imageName: "TSLA", name: "테슬라", price: 1238631, diff: 0.04),
        StockModel(rank: 9, imageName: "AAPL", name: "애플", price: 238631, diff: 1.04),
        StockModel(rank: 10, imageName: "NFLX", name: "넷플릭스", price: 438631, diff: -0.04),
        StockModel(rank: 11, imageName: "GOOG", name: "구글", price: 3176631, diff: 0.04),
        StockModel(rank: 12, imageName: "AMZN", name: "아마존", price: 3538631, diff: 0.04),
        StockModel(rank: 13, imageName: "NIKE", name: "나이키", price: 158631, diff: 0.04),
        StockModel(rank: 14, imageName: "DIS", name: "디즈니", price: 138631, diff: 0.04),
    ]
}
