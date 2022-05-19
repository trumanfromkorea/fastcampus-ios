//
//  StockRankViewController.swift
//  StockRank
//
//  Created by 장재훈 on 2022/05/19.
//

import UIKit

class StockRankViewController: UIViewController {
    let stockList: [StockModel] = StockModel.list

    @IBOutlet var collectionView: UICollectionView!

    // Data - 어떤 데이터? -> stockList
    // Presentation - cell 어떻게 표현?
    // Layout - cell 을 어떻게 배치?

    // protocol - 수행해야 하는 규칙 - 수행하는건 특정 객체

    override func viewDidLoad() {
        super.viewDidLoad()

        // 알려줄 규칙이 담겨있는것 delegate, datasource
        // 규칙을 수행할 객체 self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension StockRankViewController: UICollectionViewDataSource {
    // cell 을 몇개 쓸건지, 데이터는 몇개인지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stockList.count
    }
    
    // cell 을 어떻게 표현할지에 대한 메소드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 재사용 가능한 cell 을 가져오는것
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockRankCollectionViewCell", for: indexPath)
        
        return cell
    }
}

extension StockRankViewController: UICollectionViewDelegateFlowLayout {
}
