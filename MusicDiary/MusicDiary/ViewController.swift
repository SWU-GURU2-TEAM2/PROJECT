//
//  ViewController.swift
//  MusicDiary
//
//  Created by 1v1 on 2021/01/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func goToYujin(_ sender: Any) {
        let vc = UIStoryboard(name: "YujinStoryboard", bundle: nil).instantiateViewController(identifier: "IntroView")
        self.view.addSubview(vc.view)
    }
    

}

