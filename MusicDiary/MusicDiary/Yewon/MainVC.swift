//
//  MainView.swift
//  MusicDiary
//
//  Created by 강예원 on 2021/01/28.
//

import UIKit
import ScalingCarousel
import FirebaseFirestore

class Cell: ScalingCarouselCell {
    @IBOutlet weak var dairyImage: UIImageView!
    @IBOutlet weak var diaryName: UILabel!
    
}

class MainVC: UIViewController {
    var diary_list = [QueryDocumentSnapshot]()
    let db = Firestore.firestore()

    @IBOutlet weak var carousel: ScalingCarouselView!
    @IBOutlet weak var caroucelBotoomConstraint: NSLayoutConstraint!
    
    private struct Constants {
        static let carouselHideConstant: CGFloat = -250
        static let carouselShowConstant: CGFloat = 15
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        carousel.deviceRotated()
    }
}

typealias CarouselDatasource = ViewController
extension CarouselDatasource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
//        var diaryCount = diary_list
//        diaryCount.append()
//        let document = diaryCount[indexPath.row]
//        let data = document.data()
//        cell.diary_name.text = data["diaryName"] as! String
        
        //이미지도 동일하게 가져와서 표시... url 받아와서...
        
        
        if let scalingCell = cell as? ScalingCarouselCell {
            //scalingCell.mainView.backgroundColor = .red
            scalingCell.cornerRadius = 40
        }

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
        
        //output.text = String(describing: currentCenterIndex)
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


