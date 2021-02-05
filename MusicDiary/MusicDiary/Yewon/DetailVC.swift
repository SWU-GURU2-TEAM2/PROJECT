//
//  DetailView.swift
//  MusicDiary
//
//  Created by 강예원 on 2021/02/06.
//

import UIKit
import FirebaseFirestore

class DetailVC:UIViewController {
    //var diaryID:String!
    //var contentId:String!
    let db = Firestore.firestore()
    var ref: DocumentReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //임시로 데이터 가져오기 test UI구성 아직~
    @IBAction func test(_ sender: UIButton) {
        let docRef = db.collection("Diary").document("IxLlj4mK2DKPIoBA9Qjp").collection("Contents").document("07KdVjWloBNKuGRUOotD")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }

    }
    
}
