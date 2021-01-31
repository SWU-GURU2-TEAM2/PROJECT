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
    }

    
    
    @IBAction func goToYujin(_ sender: Any) {
        let vc = UIStoryboard(name: "YujinStoryboard", bundle: nil).instantiateViewController(identifier: "SearchView")
        self.view.addSubview(vc.view)
    }
    
    @IBAction func goToYewon(_ sender: Any) {
    }
}

