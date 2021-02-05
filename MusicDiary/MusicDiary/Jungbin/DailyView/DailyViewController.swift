//
//  DailyViewController.swift
//  MusicDiary
//
//  Created by 1v1 on 2021/01/31.
//

import UIKit
import ScalingCarousel

//class Cell: ScalingCarouselCell {}

class DailyViewController: UIViewController {
    //@IBOutlet weak var carousel: ScalingCarouselView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
//
//typealias CarouselDatasource = ViewController
//extension CarouselDatasource:UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//
//
//        if let scalingCell = cell as? ScalingCarouselCell {
//            scalingCell.mainView.backgroundColor = .red
//            scalingCell.cornerRadius = 80
//        }
//
//        DispatchQueue.main.async {
//            cell.setNeedsLayout()
//            cell.layoutIfNeeded()
//        }
//        return cell
//}
//
//typealias CarouselDelegate = ViewController
//extension ViewController: UICollectionViewDelegate {
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        carousel.didScroll()
//
//        guard let currentCenterIndex = self.carousel.currentCenterCellIndex?.row else { return }
//
//        print("current index: ", String(describing: currentCenterIndex))
//    }
//}
//
//private typealias ScalingCarouselFlowDelegate = ViewController
//extension ScalingCarouselFlowDelegate: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 0
//    }
//}
