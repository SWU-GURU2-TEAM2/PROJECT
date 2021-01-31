//
//  LoginViewController.swift
//  MusicDiary
//
//  Created by 강유진 on 2021/01/31.
//

import UIKit
import FirebaseUI

//구글 로그인...
class LoginViewcontroller: UIViewController, FUIAuthDelegate{
    
    //values
    let authUI = FUIAuth.defaultAuthUI()
    var handle: AuthStateDidChangeListenerHandle!
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }//viewDidLoad
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    
    //viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let currentUser = auth.currentUser {
                //Logged User
                let alertController = UIAlertController(title: "Welcome", message: "\(currentUser.displayName!)!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: false, completion: nil)
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
    }//ViewWillAppear
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        print("signin")
        print(authDataResult)
    }
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try authUI?.signOut()
        } catch {
            print("logoutError")
        }
        
    }
    
    
}//LoginViewController

//자동로그인 화면..
class LogedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
