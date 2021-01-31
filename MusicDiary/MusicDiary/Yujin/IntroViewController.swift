//
//  ViewController.swift
//  MDBackupProject
//
//  Created by 강유진 on 2021/01/29.
//

import UIKit
import SwiftyGif

class IntroViewController: UIViewController {

    //values
    
    @IBOutlet var introView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var gestureView: UIView!
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do{
            let gif = try UIImage(gifName: "spongeBob.gif")
            self.logoImageView.setGifImage(gif, loopCount: -1)
        } catch {
            print("not loaded")
        }
        /* ERROR */
        /*
        self.view.bringSubviewToFront(gestureView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        gestureView.isUserInteractionEnabled = true
        gestureView.addGestureRecognizer(tap)
        */
        
        
        //자동 로그인 여부 확인
    }//viewDidLoad

    //viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //gif 애니메이션 종료
        self.logoImageView.stopAnimatingGif()
    }//viewDidDisappear
    
    /*
    @objc func tapped(_ sender: UITapGestureRecognizer){
        print(sender)
    }
 */
}
