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
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var singer: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var contentText: UITextView!
    
    let db = Firestore.firestore()
    var ref: DocumentReference!
    var contentData:ContentData!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let docRef = db.collection("Diary").document("IxLlj4mK2DKPIoBA9Qjp").collection("Contents").document("9G2Dh6BvPGmsJIynqWtv")

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

class DetailSub1VC: DetailVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
class DetailSub2VC: DetailVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
