////
////  EditViewController.swift
////  MusicDiary
////
////  Created by 1v1 on 2021/02/07.
////
//
//import UIKit
//import Firebase
//
//var currentContentID = "ytGhBqaCnQAdq3feUqhI"
//var newCD = ContentData()
//
//class EditViewControllerrrrr: UIViewController, SendDataDelegate {
//    func sendData(data: MusicStruct) {
//        getMusic = data
//        titleLabel.text = getMusic.musicTitle
//        artistLabel.text = getMusic.musicArtist
//        DispatchQueue.global().async { let data = try? Data(contentsOf: self.getMusic.musicCoverUrl!)
//            DispatchQueue.main.async { self.imageView.image = UIImage(data: data!) }
//        }
//        self.viewDidLoad()
//
//    }
//
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var artistLabel: UILabel!
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var textView: UITextView!
//    var getMusic:MusicStruct!
//    let db = Firestore.firestore()
//
//    var ref: DocumentReference? = nil
//    var docRef: DocumentReference? = nil
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        placeholderSetting()
//        presentData()
//
//
////        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
////        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification , object: nil)
//
//    }
//    @IBAction func go(_ sender: Any) {
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
//
//    func presentData() {
//
//        docRef =  db.collection("Diary").document("\(currentDairyId)").collection("Contents").document("\(currentContentID)")
//        docRef!.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let getContent = document.data()
//                newCD = ContentData(
//                    authorID: getContent!["authorID"] as! String,
//                    conentText: getContent!["contentText"] as! String,
//                    musicTitle: getContent!["musicTitle"] as! String,
//                    musicArtist: getContent!["musicArtist"] as! String,
//                    musicCoverUrl: URL(string: "\(getContent!["musicCoverUrl"])"),
//                    date: getContent!["date"] as? Date)
//                print(newCD)
//                self.viewDidLoad()
//
//
//            } else {
//                print("Document does not exist")
//            }
//        }
//
//        //titleLabel.text = newCD.musicTitle
//       // artistLabel.text = newCD.musicArtist
//        textView!.text = newCD.conentText!
////        DispatchQueue.global().async { let data = try? Data(contentsOf: newCD.musicCoverUrl!)
////            DispatchQueue.main.async { self.imageView.image = UIImage(data: data!) }
////        }
//    }
//
//
//    @IBAction func tapSaveBtn(_ sender: Any) {
//        // EDIT
//        let calendar = Calendar.current
//
//        self.docRef!.updateData( [
//            "contentText":"\(textView.text!)",
//            "musicArtist":"\(artistLabel.text!)",
//            "musicCoverUrl":"\(self.getMusic.musicCoverUrl!.absoluteString)",
//            "musicTitle":"\(titleLabel.text!)"
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document updated with ID: \(self.docRef!.documentID)")
//            }
//        }
//        self.dismiss(animated: true)
//
//    }
//    @IBAction func goSearchBtn(_ sender: Any) {
//        let board = UIStoryboard(name: "YujinStoryboard", bundle: nil)
//        guard let vc = board.instantiateViewController(identifier: "SearchView") as? SearchViewController else {return}
//        self.present(vc, animated: true, completion: nil)
//        vc.delegate = self
//
//    }
//
//    @IBAction func tapView(_ sender: Any) {
//        self.dismiss(animated: true)
//    }
//
//    @objc func keyboardWillAppear(_ sender: NotificationCenter){
//        self.view.frame.origin.y -= 130
//    }
//    @objc func keyboardWillDisappear(_ sender: NotificationCenter){
//        self.view.frame.origin.y += 130
//    }
//}
//
//extension EditViewController: UITextViewDelegate {
//    func placeholderSetting() {
//        textView.delegate = self // txtvReview가 유저가 선언한 outlet
//        textView.text = "오늘의 감상, 기분, 일기를 기록하세요. 📝"
//        textView.textColor = UIColor.lightGray
//
//    }
//
//
//    // TextView Place Holder
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == UIColor.lightGray {
//            textView.text = nil
//            textView.textColor = UIColor.black
//        }
//
//    }
//    // TextView Place Holder
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = "오늘의 감상, 기분, 일기를 기록하세요. 📝"
//            textView.textColor = UIColor.lightGray
//        }
//    }
//}
//
