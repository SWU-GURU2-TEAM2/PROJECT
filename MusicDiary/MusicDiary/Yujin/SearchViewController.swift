//
//  SearchViewController.swift
//  MusicDiary
//
//  Created by 강유진 on 2021/02/01.
//

import UIKit
import Alamofire
import SwiftyXMLParser

//SearchViewController
class SearchViewController: UIViewController {
    //values
    @IBOutlet weak var tableView: UITableView! //tableView
    @IBOutlet weak var searchTextField: UITextField! //searchTextField
    @IBOutlet weak var songArtistSegment: UISegmentedControl! //songArtistSegment
    var MusicData = [MusicStruct]()
    var searchKeyword: String = ""
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }//viewDidLoad
    
    //searchButtonPressed
    @IBAction func searchButtonPressed(_ sender: Any) {
        //텍스트필드의 값 확인
        searchKeyword = searchTextField.text ?? ""
        if searchKeyword != "" {
            //Alamofire로 필요한 정보 가져오기
            print("start Alamofire")
            //MusicData 배열에 데이터 저장하기
            switch songArtistSegment.selectedSegmentIndex {
            case 0:
                AF.request("http://www.maniadb.com/api/search/\(searchKeyword)/?sr=song&display=10&key=example&v=0.5", encoding: URLEncoding.httpBody, headers: nil).responseData { (response) in
                    print("response SONG")
                }
            case 1:
                AF.request("http://www.maniadb.com/api/search/\(searchKeyword)/?sr=artist&display=10&key=example&v=0.5", encoding: URLEncoding.httpBody, headers: nil).responseData { (response) in
                    print("response ARTIST")
                }
            default:
                print("nonSelected")
            }
        }
        print("end The Search")
    }//searchButtonPressed
    
}//SearchViewController

//extension SearchViewController (TableView_DataSource)
extension SearchViewController: UITableViewDataSource {
    //numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }//numberOfRowsInSection
    
    //cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //스토리보드의 셀을 형식으로, MusicData의 정보로 셀을 구성. (제목, 제작자, 앨범아트)
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell") as! SearchResultCell
        cell.musicTitle.text = "Name"
        cell.musicArtist.text = "Artist"
        let url = URL(string: "https://i.pinimg.com/originals/2e/32/ee/2e32eefcb9bb70604d2ef0a88ed4329c.jpg")
        do {
            let data = try Data(contentsOf: url!)
            cell.musicCover.image = UIImage(data: data)
        } catch {
            //스토리 보드의 기본 이미지 그대로 사용
        }
        return cell
        
    }//cellForRowAt
    
}//searchViewController

//extension SearchViewController (TableView_Delegate)
extension SearchViewController: UITableViewDelegate{
    //tableView_heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //세로모드, 가로 모드에 따라 한 번에 보여줄 테이블 셀 갯수 조절
        let size = tableView.frame.size
        if size.height > size.width {
            return size.height / 10
        } else {
            return size.height / 5
        }
        
    }
}//SearchViewController

//SearchResultViewController
class SearchResultViewController: UIViewController {
    
    //노래 검색 결과만 필요할까봐 만들어둔 것. 필요없으면 추후 삭제 요망.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
