//
//  DailyViewController.swift
//  MusicDiary
//
//  Created by 1v1 on 2021/01/31.
//

import UIKit
import ScalingCarousel
import FSCalendar
import Firebase

var currentDairyId = "IxLlj4mK2DKPIoBA9Qjp"
class DailyCell: ScalingCarouselCell {
    
    @IBOutlet weak var titleLabel: UILabel!
}
class DailyViewController: UIViewController, FSCalendarDelegate {
    
    var todayContentList:[ContentData] = [ContentData()]
    var datesWithEvent = [Date(), Date()-86400]
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var dailyCarousel: ScalingCarouselView!
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noDataLabel.alpha = 0
        calendar.delegate = self
        getContentsListForDaily(date: Date())
        
        calendar.appearance.titleDefaultColor = .black
        calendar.appearance.titleWeekendColor = .black
        // 달력의 맨 위의 년도, 월의 색깔
        calendar.appearance.headerTitleColor = .black
        // 달력의 요일 글자 색깔
        calendar.appearance.weekdayTextColor = .black
        //년 월 custom
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        dailyCarousel.deviceRotated()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if self.datesWithEvent.contains(date) {
            calendar.reloadData()
            return [UIColor.magenta, appearance.eventDefaultColor, UIColor.black]
        }
        calendar.reloadData()

        return [appearance.eventDefaultColor]
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // 아래 그날의 글들 보여주기
        noDataLabel.alpha = 0
        print("selected date: ", date)
        getContentsListForDaily(date: date)
        
        
    }
    
    func getContentsListForDaily(date: Date) {
        let db = Firestore.firestore()
        let calendar = Calendar.current
        
        self.todayContentList = []
        // .whereField("date", isLessThan: calendar.startOfDay(for: date)+86400)
        db.collection("Diary").document("\(currentDairyId)").collection("Contents") .whereField("date", isGreaterThanOrEqualTo: calendar.startOfDay(for: date)).whereField("date", isLessThan: calendar.startOfDay(for: date)+86400).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let getContent = document.data()
                    let newCD = ContentData(
                        authorID: getContent["authorID"] as! String,
                        conentText: getContent["contentText"] as! String,
                        musicTitle: getContent["musicTitle"] as! String,
                        musicArtist: getContent["musicArtist"] as! String,
                        musicCoverUrl: URL(string: "\(getContent["musicCoverUrl"])"),
                        date: getContent["date"] as? Date)
                    self.todayContentList.append(newCD)
                    //print("\(document.documentID) => \(document.data())")
                    
                    
                }
                print("today content list: ", self.todayContentList)
                if self.todayContentList.count == 0 {
                    self.noDataLabel.alpha = 1
                }
                self.dailyCarousel.reloadData()
            }
        }
        
    }
    
    
}
extension DailyViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayContentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dailyCarousel.dequeueReusableCell(withReuseIdentifier: "dailyCell", for: indexPath) as! DailyCell
        cell.titleLabel.text = todayContentList[indexPath.row].musicTitle
        
        if let dailyScalingCell = cell as? ScalingCarouselCell {
            dailyScalingCell.contentView.backgroundColor = .lightGray
            dailyScalingCell.cornerRadius = 50
        }
        
        DispatchQueue.main.async {
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        
        return cell
    }
    
    
}
extension DailyViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dailyCarousel.didScroll()
        
        guard let currentCenterIndex = dailyCarousel.currentCenterCellIndex?.row else { return }
        
        print(String(describing: currentCenterIndex))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
}

