//
//  MainView.swift
//  MusicDiary
//
//  Created by 강예원 on 2021/01/28.
//

import UIKit
import ScalingCarousel
import FirebaseFirestore

class MainCell: ScalingCarouselCell {
    @IBOutlet weak var diaryIamage: UIImageView!
    @IBOutlet weak var diaryName: UILabel!
}

class MainVC:UIViewController {
    let db = Firestore.firestore()
    var diaryData = [DiaryStructure]()
    var diaryList = [QueryDocumentSnapshot]()

    @IBOutlet weak var mainCarousel: ScalingCarouselView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.collection("Users").getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                                print("\(document.documentID) => \(document.data()["userDiaryList"])")
                    self.diaryList.append(document)
            }
                self.mainCarousel.reloadData()
        }
    }
        
    }
        
    
    @IBAction func addDiary(_ sender: UIButton) {
        //self.diaryList.append()
        //self.mainCarousel.reloadData()

        //firebase에 다이어리 증가 + 유저 다이어리 리스트에도 추가 됨
        var ref: DocumentReference? = nil

        ref = db.collection("Diary").addDocument(data: [
            "diaryImageUrl":"",
            "diaryName":"",
            "memberList":[]
            //memberList에 currentUserId 들거갈 것 예상
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        db.collection("Users").document("TNrcZtxj42Mfqq2KRy1A").updateData([
            "userDiaryList": FieldValue.arrayUnion([ref!.documentID])
        ])
        
        
    }
    
    @IBAction func moveToWrite(_ sender: UIButton) {
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        mainCarousel.deviceRotated()
    }
}

typealias CarouselDatasource = MainVC
extension CarouselDatasource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let carouselCell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as! MainCell
        
        
        carouselCell.setNeedsLayout()
        carouselCell.layoutIfNeeded()
        
        return carouselCell
    }
}

typealias CarouselDelegate = MainVC
extension MainVC: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let mainCurrentCenterIndex = mainCarousel.currentCenterCellIndex?.row
        else {
            return
            
        }
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

