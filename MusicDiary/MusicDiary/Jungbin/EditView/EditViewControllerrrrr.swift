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
//    
//
//
//    @IBAction func tapSaveBtn(_ sender: Any) {

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
//
//    @objc func keyboardWillAppear(_ sender: NotificationCenter){
//        self.view.frame.origin.y -= 130
//    }
//    @objc func keyboardWillDisappear(_ sender: NotificationCenter){
//        self.view.frame.origin.y += 130
//    }
//}
//

//
