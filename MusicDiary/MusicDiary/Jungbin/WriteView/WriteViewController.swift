//
//  WriteViewController.swift
//  MusicDiary
//
//  Created by 1v1 on 2021/01/31.
//

import UIKit
import Firebase

var newContent = ContentData(authorID: "userID123", conentText: "", musicTitle: "", musicArtist: "", musicCoverUrl: URL(fileURLWithPath: "https://"), date: Date())

class WriteViewController:UIViewController, SendDataDelegate{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    var getMusic:MusicStruct!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func tapSaveBtn(_ sender: Any) {
        newContent.conentText = textView.text
        
        // 테스트 용
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.tempDiary.append(newContent)
        
        // 데이터 firebase에 저장
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        
        print("newContent in Save: ", newContent)
        ref = db.collection("Diary/IxLlj4mK2DKPIoBA9Qjp/Contents").addDocument(data: [
            "authorID": "\(newContent.authorID!)",
            "contentText":"\(newContent.conentText!)",
            "date":newContent.date!,
            "musicArtist":"\(newContent.musicArtist!)",
            "musicCoverUrl":"\(newContent.musicCoverUrl?.absoluteString))",
            "musicTitle":"\(newContent.musicTitle!)"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        self.dismiss(animated: true)
        
    }
    @IBAction func goSearchBtn(_ sender: Any) {
        let board = UIStoryboard(name: "YujinStoryboard", bundle: nil)
        guard let vc = board.instantiateViewController(identifier: "SearchView") as? SearchViewController else {return}
        self.present(vc, animated: true, completion: nil)
        vc.delegate = self
        
    }
    
    @IBAction func tapView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func sendData(data: MusicStruct) {
        getMusic = data
        titleLabel.text = getMusic.musicTitle
        artistLabel.text = getMusic.musicArtist
        DispatchQueue.global().async { let data = try? Data(contentsOf: self.getMusic.musicCoverUrl!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async { self.imageView.image = UIImage(data: data!) }
        }
        self.viewDidLoad()
        
        newContent.musicArtist = getMusic.musicArtist
        newContent.musicTitle = getMusic.musicTitle
        newContent.musicCoverUrl = getMusic.musicCoverUrl
        
        
    }
}

extension WriteSubVC2: UITextViewDelegate {
    func placeholderSetting() {
        textView.delegate = self // txtvReview가 유저가 선언한 outlet
        textView.text = "오늘의 감상, 기분, 일기를 기록하세요. 📝"
        textView.textColor = UIColor.lightGray
        
    }
    
    
    // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "오늘의 감상, 기분, 일기를 기록하세요. 📝"
            textView.textColor = UIColor.lightGray
        }
    }
}
