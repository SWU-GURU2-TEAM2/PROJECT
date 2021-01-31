//
//  IntroViewController.swift
//  MusicDiary
//
//  Created by 강유진 on 2021/01/31.
//

import UIKit
import FirebaseUI


class IntroViewController: UIViewController, FUIAuthDelegate {
    
    //values
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        swipeLable.addGestureRecognizer(tap)
        swipeLable.isEnabled = true
    }//viewDidLoad
    
    //viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle)
    }//viewDidDisappear
    
    //labelTapped
    @objc func labelTapped (_ sender: UITapGestureRecognizer) {
        print("tapped")
    }//labelTapped
    
    //btnTouched
    @IBAction func btnTouched(_ sender: Any) {
        print("touched")
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let currentUser = auth.currentUser {
                //Logged User
                let vc = UIStoryboard(name: "YujinStoryboard", bundle: nil).instantiateViewController(identifier: "LoggedView")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion:  nil)
            } else {
                //Not Logged
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
        do {
            try authUI?.signOut()
        } catch {
            print("logoutError")
        }
    }//logoutbtnTouched
    
}
