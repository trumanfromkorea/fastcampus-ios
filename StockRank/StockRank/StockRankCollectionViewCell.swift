//
//  StockRankCollectionViewCell.swift
//  StockRank
//
//  Created by 장재훈 on 2022/05/19.
//

import UIKit

class StockRankCollectionViewCell: UICollectionViewCell {
    // UIComponent 연결
    // UIComponent 데이터를 업데이트하는 코드를 넣자

    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var companyIconImageView: UIImageView!

    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var companyPriceLabel: UILabel!
    @IBOutlet var diffLabel: UILabel!

    func configure(_ stock: StockModel) {
        rankLabel.text = "\(stock.rank)"
        companyIconImageView.image = UIImage(named: stock.imageName)

        companyNameLabel.text = stock.name
        companyPriceLabel.text = "\(convertToCurrencyFormat(stock.price)) 원"
        diffLabel.text = "\(stock.diff)%"

        diffLabel.textColor = stock.diff < 0 ? .systemBlue : .systemRed
    }

    func convertToCurrencyFormat(_ price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0

        return numberFormatter.string(from: NSNumber(value: price)) ?? ""
    }
}
