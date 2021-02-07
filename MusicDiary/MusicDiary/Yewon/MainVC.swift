//
//  MainView.swift
//  MusicDiary
//
//  Created by 강예원 on 2021/01/28.
//

import UIKit
import WebKit
import ScalingCarousel
import FirebaseFirestore
import FirebaseAuth
import FirebaseUI

class MainCell: ScalingCarouselCell {
    @IBOutlet weak var MainDiaryIamage: UIImageView!
    @IBOutlet weak var mainDiaryName: UILabel!
    
}

class MainVC:UIViewController {
    let db = Firestore.firestore()
    var diaryData = [QueryDocumentSnapshot]()
    var getDiaryList = [QueryDocumentSnapshot]()
    @IBOutlet weak var mainCarousel: ScalingCarouselView!
    let authUI = FUIAuth.defaultAuthUI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.diaryData = [QueryDocumentSnapshot]()
        self.getDiaryList = [QueryDocumentSnapshot]()
        
        //Users>diaryList
        db.collection("Users").getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    print("\(document.documentID) => \(document.data()["userDiaryList"])")
                    self.getDiaryList.append(document.data()["userDiaryList"] as! QueryDocumentSnapshot)
                }
                self.mainCarousel.reloadData()
            }
            self.db.collection("Users").addSnapshotListener { (snapshot, error) in
                if let error = error {
                    print(error)
                    return
                }
                if let snapshot = snapshot {
                    for change in snapshot.documentChanges {
                        print(change.document.data()["userDiaryList"])
//                        let docID = change.document.documentID
//                        let document = change.document
//                        self.getDiaryList = document.data()["userDiaryList"] as! [String]
//                        self.mainCarousel.reloadData()
                    }
                }
            }

        }
        //Diary>data
        db.collection("Diary").getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            if let snapshot = snapshot {
                for document in snapshot.documents {
                                print("\(document.documentID) => \(document.data())")
                    self.diaryData.append(document)
                    self.mainCarousel.reloadData()

                }
            }
        }
    }
        
    
    @IBAction func addDiary(_ sender: UIButton) {

        //firebase에 다이어리 증가 + 유저 다이어리 리스트에도 추가 됨
        var ref: DocumentReference? = nil
        let date = Date()

        ref = db.collection("Diary").addDocument(data: [
            "diaryImageUrl":"",
            "diaryName":"test",
            "memberList":[],
            "date":date
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
        self.mainCarousel.reloadData()
        
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
        return self.getDiaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let carouselCell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as! MainCell
//        let document = diaryData[indexPath.row]
//        let data = document.data()
//        carouselCell.mainDiaryName.text = data["diaryName"] as! String
//        //carouselCell.MainDiaryIamage.image = data["diaryImageUrl"] as! UIImage
        
        
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

