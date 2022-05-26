//
//  OnboardingViewController.swift
//  NRCOnboarding
//
//  Created by 장재훈 on 2022/05/26.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!

    let messages: [OnboardingMessage] = OnboardingMessage.messages

    override func viewDidLoad() {
        super.viewDidLoad()

        // data, presentaion, layout
        collectionView.delegate = self
        collectionView.dataSource = self

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }

        pageControl.numberOfPages = messages.count
        pageControl.currentPage = 0
    }

    // button 으로 pageControl 조정하는법 알고싶다
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }

        let message = messages[indexPath.item]
        cell.configure(message)

        return cell
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    // didscroll 은 스크롤할때마다
    // 이건 감속하면서 멈추는
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let width = collectionView.bounds.width

        let index = Int(offset / width)

        pageControl.currentPage = index
    }
}
