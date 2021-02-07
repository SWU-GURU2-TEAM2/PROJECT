//
//  IntroViewController.swift
//  MusicDiary
//
//  Created by 강유진 on 2021/01/31.
//

import UIKit
import FirebaseUI
import SwiftyGif
import FirebaseFirestore

class IntroViewController: UIViewController, FUIAuthDelegate, UIGestureRecognizerDelegate {
    
    //values
    @IBOutlet weak var logoImageView: UIImageView! //logoImageView
    @IBOutlet weak var swipeLable: UILabel! //swipeLabel
    let authUI = FUIAuth.defaultAuthUI() //authUI
    let db = Firestore.firestore() //db
    var handle: AuthStateDidChangeListenerHandle! //handle
    var currentUID:String! //currentUID
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //logoImageView GIF start
        do{
            let gif = try UIImage(gifName: "spongeBob.gif")
            self.logoImageView.setGifImage(gif, loopCount: -1)
        } catch {
            print("not loaded")
        }
        
        //swipeGestureControl
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestured(_:)))
        swipeGestureRecognizer.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeGestureRecognizer)
    }//viewDidLoad
    
    //viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //firebase auth listener 삭제
        Auth.auth().removeStateDidChangeListener(handle)
    }//viewDidDisappear
    
    //swipeGesture
    @IBAction func swipeGestured(_ sender: Any) {
        print("swiped")
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            //만약 로그인 했다면
            if let currentUser = auth.currentUser {
                //currentUser 정보 넘겨주기
                //로그인한 유저 -> 다음 뷰로 넘어감
                let docRef = self.db.collection("Users").document("\(currentUser.uid)")
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        print("Document data: \(dataDescription)")
                    } else {
                        print("Document does not exist")
                        self.db.collection("Users").document("\(currentUser.uid)").setData(["userDiaryList" : [],
                             "userID" : "\(currentUser.uid)",
                             "userImage" : "",
                             "userName" : "\(currentUser.displayName!)"])
                        print("UserDataSaved")
                    }
                }
                
                let vc = UIStoryboard(name: "YewonStoryboard", bundle: nil).instantiateViewController(identifier: "YewonMainView")
                vc.modalPresentationStyle = .fullScreen
                self.currentUID = currentUser.uid
                print(self.currentUID!)
                self.present(vc, animated: true, completion:  nil)
            } else {
                //로그인 안한 유저 -> 로그인 화면이 뜸
                self.authUI!.delegate = self
                  let providers: [FUIAuthProvider] = [
                  FUIGoogleAuth()
                ]
                self.authUI!.providers = providers
                let authViewController = self.authUI!.authViewController()
                authViewController.modalPresentationStyle = .fullScreen
                authViewController.setNavigationBarHidden(true, animated: false)
                self.present(authViewController, animated: true, completion: nil)
            }//if else
        }//handle
    }//swipeGestured
    
    //logoutbtnTouched
    @IBAction func logoutbtnTouched(_ sender: Any) {
        print("logOut")
        //로그아웃 시도
        do {
            try authUI?.signOut()
        } catch {
            print("logoutError")
        }
    }//logoutbtnTouched
    
}
