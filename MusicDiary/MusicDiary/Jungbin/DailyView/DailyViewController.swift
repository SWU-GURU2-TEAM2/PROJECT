//
//  DailyViewController.swift
//  MusicDiary
//
//  Created by 1v1 on 2021/01/31.
//

import UIKit

class DailyViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()
    }
    
    @IBAction func changeDatePicker(_ sender: Any) {
        print(datePicker.date)
        
        //날짜 변경할 때마다 아래에 나오는 다이어리 바뀜!
    }
    func setDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date(timeIntervalSinceNow: -86400)
        datePicker.maximumDate = Date(timeIntervalSinceNow: 86400)
    }
}

