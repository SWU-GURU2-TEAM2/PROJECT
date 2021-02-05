//
//  WriteViewController.swift
//  MusicDiary
//
//  Created by 1v1 on 2021/01/31.
//

import UIKit
import Firebase

class WriteViewController:UIViewController{
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView(_:)))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func tapSaveBtn(_ sender: Any) {
        var newContent = ContentData()
        newContent.authorID = "aaa111"
        newContent.conentText = textView.text
        newContent.date = Date()
        newContent.musicArtist = "태진아"
        newContent.musicTitle = "진진자라"
        newContent.musicCoverUrl = URL(string:"https://avatars.githubusercontent.com/u/4277927?s=64&v=4")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.tempDiary.append(newContent)
        print("저장된 내용 목록: ", appDelegate.tempDiary)
        
        // 데이터 firebase에 저장
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        
        ref = db.collection("Diary/IxLlj4mK2DKPIoBA9Qjp/Contents").addDocument(data: [
            "authorID": "\(String(describing: newContent.authorID))",
            "contentText":"\(String(describing: newContent.conentText))",
            "date":"\(String(describing: newContent.date))",
            "musicArtist":"\(String(describing: newContent.musicArtist))",
            "musicCoverUrl":"\(String(describing: newContent.musicCoverUrl))",
            "musicTitle":"\(String(describing: newContent.musicTitle))"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        self.dismiss(animated: true)
        
        
    }
    
    @IBAction func tapView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
