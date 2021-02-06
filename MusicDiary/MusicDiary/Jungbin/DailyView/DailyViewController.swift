//
//  DailyViewController.swift
//  MusicDiary
//
//  Created by 1v1 on 2021/01/31.
//

import UIKit
import ScalingCarousel
import FSCalendar

class DailyCell: ScalingCarouselCell {}
class DailyViewController: UIViewController, FSCalendarDelegate {
    
    @IBOutlet weak var dailyCarousel: ScalingCarouselView!
    @IBOutlet weak var calendar: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        // 달력의 평일 날짜 색깔
        calendar.appearance.titleDefaultColor = .black
        // 달력의 토,일 날짜 색깔
        calendar.appearance.titleWeekendColor = .black
        // 달력의 맨 위의 년도, 월의 색깔
        calendar.appearance.headerTitleColor = .black
        // 달력의 요일 글자 색깔
        calendar.appearance.weekdayTextColor = .black
        // 년월에 흐릿하게 보이는 애들 없애기
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        //년 월 custom
        calendar.appearance.headerDateFormat = "YYYY년 M월"
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        dailyCarousel.deviceRotated()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // 아래 그날의 글들 보여주기
        print("selected date: ", date)
    }
    
    
    
}
extension DailyViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dailyCarousel.dequeueReusableCell(withReuseIdentifier: "dailyCell", for: indexPath)
        
        
        if let dailyScalingCell = cell as? ScalingCarouselCell {
            dailyScalingCell.contentView.backgroundColor = .gray
            dailyScalingCell.cornerRadius = 50
        }

        DispatchQueue.main.async {
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }
        
        return cell
    }
    
    
}
extension DailyViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dailyCarousel.didScroll()
        
    }
    
}
