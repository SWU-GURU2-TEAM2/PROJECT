//
//  WriteViewController.swift
//  MusicDiary
//
//  Created by 1v1 on 2021/01/31.
//

import UIKit
class WriteViewController:UIViewController{
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView(_:)))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func tapSaveBtn(_ sender: Any) {
        // 다이어리에 저장 기능 수행 후
        self.dismiss(animated: true)
        
        
    }
    
    @IBAction func tapView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
