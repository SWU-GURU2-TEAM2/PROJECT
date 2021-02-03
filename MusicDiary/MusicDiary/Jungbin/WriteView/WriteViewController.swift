//
//  WriteViewController.swift
//  MusicDiary
//
//  Created by 1v1 on 2021/01/31.
//

import UIKit

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
        newContent.musicArtist = "아이유"
        newContent.musicTitle = "너랑 나"
        newContent.musicCoverUrl = URL(string:"https://avatars.githubusercontent.com/u/4277927?s=64&v=4")

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.tempDiary.append(newContent)
        print("저장된 내용 목록: ", appDelegate.tempDiary)
        self.dismiss(animated: true)
        
        
    }
    
    @IBAction func tapView(_ sender: Any) {
        self.dismiss(animated: true)
    }

}
