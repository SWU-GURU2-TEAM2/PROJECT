//
//  IntroViewController.swift
//  MusicDiary
//
//  Created by 강유진 on 2021/01/31.
//

import UIKit
import FirebaseUI
import SwiftyGif


class IntroViewController: UIViewController, FUIAuthDelegate {
    
    //values
    @IBOutlet weak var logoImageView: UIImageView! //logoImageView
    @IBOutlet weak var swipeLable: UILabel! //swipeLabel
    let authUI = FUIAuth.defaultAuthUI() //authUI
    var handle: AuthStateDidChangeListenerHandle! //handle
    
    //viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
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
        /* labelTapped Test
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        swipeLable.addGestureRecognizer(tap)
        swipeLable.isEnabled = true
         */
    }//viewDidLoad
    
    //viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //firebase auth listener 삭제
        Auth.auth().removeStateDidChangeListener(handle)
        //logoImageView GIF 멈춤
        //self.logoImageView.stopAnimatingGif()
    }//viewDidDisappear
    
    //labelTapped
    @objc func labelTapped (_ sender: UITapGestureRecognizer) {
        print("tapped")
    }//labelTapped
    
    //btnTouched
    @IBAction func btnTouched(_ sender: Any) {
        print("touched")
        //핸들로 로그인 했는지 안했는지 추적
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            //만약 로그인 했다면
            if let currentUser = auth.currentUser {
                //currentUser 정보 넘겨주기
                print(currentUser.displayName)
                //로그인한 유저 -> 다음 뷰로 넘어감
                let vc = UIStoryboard(name: "YujinStoryboard", bundle: nil).instantiateViewController(identifier: "LoggedView")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion:  nil)
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
            }
        }
    }//btnTouched
    
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
