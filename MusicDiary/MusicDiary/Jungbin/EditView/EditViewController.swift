//
//  EditViewController.swift
//  MusicDiary
//
//  Created by 1v1 on 2021/02/07.
//

import UIKit
import Firebase

var currentContentID = "3QlbFquOKWsqCLOTDpTv"
var newCD = ContentData()

class EditViewController: UIViewController, SendDataDelegate {
    func sendData(data: MusicStruct) {
        getMusic = data
        
        DispatchQueue.global().async { let data = try? Data(contentsOf: self.getMusic.musicCoverUrl!)
            DispatchQueue.main.async {
                self.imageVIew.image = UIImage(data: data!)
                self.titleLabel.text = self.getMusic.musicTitle
                self.artistLabel.text = self.getMusic.musicArtist
            }
        }
        
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var musicView: UIView!
    @IBOutlet weak var writeView: UIView!
    var getMusic:MusicStruct!
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        presentData()
        //placeholderSetting()
        
    }
    @IBAction func tapSaveBtn(_ sender: Any) {
        // EDIT
        let calendar = Calendar.current
        var docRef = db.collection("Diary").document("\(currentDairyId)").collection("Contents").document("\(currentContentID)")

        docRef.updateData( [
            "contentText":"\(textView.text!)",
            "musicArtist":"\(artistLabel.text!)",
            "musicCoverUrl":String(describing: newContent.musicCoverUrl!),
            "musicTitle":"\(titleLabel.text!)"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document updated with ID: \(docRef.documentID)")
            }
        }
        self.dismiss(animated: true)
        
    }
    @IBAction func tapSearchBtn(_ sender: Any) {
        let board = UIStoryboard(name: "YujinStoryboard", bundle: nil)
        guard let vc = board.instantiateViewController(identifier: "SearchView") as? SearchViewController else {return}
        self.present(vc, animated: true, completion: nil)
        vc.delegate = self
    }
    @IBAction func tapVIew(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func presentData() {
        var docRef = db.collection("Diary").document("\(currentDairyId)").collection("Contents").document("\(currentContentID)")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                newContent.musicCoverUrl = URL(string: (dataDescription!["musicCoverUrl"]! as? String)!)
                
                newCD.authorID = dataDescription!["authorID"] as? String
                newCD.conentText = dataDescription!["contentText"] as? String
                newCD.musicTitle = dataDescription!["musicTitle"] as? String
                newCD.musicArtist = dataDescription!["musicArtist"] as? String
                newCD.musicCoverUrl = URL(string: (dataDescription!["musicCoverUrl"]! as? String)!)
                newCD.date = dataDescription!["date"] as? Date
                self.titleLabel.text = newCD.musicTitle
                self.artistLabel.text = newCD.musicArtist
                self.textView!.text = newCD.conentText
                
                //print("Document data: ", newURL)
                
                DispatchQueue.global().async { let data = try? Data(contentsOf: newCD.musicCoverUrl!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    DispatchQueue.main.async { self.imageVIew.image = UIImage(data: data!) }
                }
                
            } else {
                print("Document does not exist")
            }
        }
        
        
    }
    
}
extension EditViewController: UITextViewDelegate {
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
