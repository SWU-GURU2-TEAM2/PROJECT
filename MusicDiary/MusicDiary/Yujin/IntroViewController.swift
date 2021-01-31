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
    @IBOutlet weak var logoImageView: UIImageView!
    
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
    }//viewDidLoad

    //viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //gif 애니메이션 종료
        self.logoImageView.stopAnimatingGif()
    }//viewDidDisappear
    

}
