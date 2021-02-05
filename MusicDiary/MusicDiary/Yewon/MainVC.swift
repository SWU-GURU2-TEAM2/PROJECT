//
//  MainView.swift
//  MusicDiary
//
//  Created by 강예원 on 2021/01/28.
//

import UIKit
import ScalingCarousel

class carouselCell: ScalingCarouselCell {
    @IBOutlet weak var diaryName: UILabel!
    
}

class MainVC: UIViewController {
    
    @IBOutlet weak var carousel: ScalingCarouselView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        carousel.deviceRotated()
    }
}

typealias CarouselDatasource = MainVC
extension CarouselDatasource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        

        DispatchQueue.main.async {
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        
        return cell
    }
}

typealias CarouselDelegate = MainVC
extension MainVC: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        carousel.didScroll()
        
        guard let currentCenterIndex = carousel.currentCenterCellIndex?.row else { return }
        
    }
}

private typealias ScalingCarouselFlowDelegate = MainVC
extension ScalingCarouselFlowDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
}
