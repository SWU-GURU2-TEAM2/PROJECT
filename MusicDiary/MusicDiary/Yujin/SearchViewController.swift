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
    var musicData = [MusicStruct]()
    var searchKeyword: String = ""
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }//viewDidLoad
    
    //searchButtonPressed
    @IBAction func searchButtonPressed(_ sender: Any) {
        //텍스트필드의 값 확인
        musicData.removeAll()
        searchKeyword = searchTextField.text ?? ""
        if searchKeyword != "" {
            //Alamofire로 필요한 정보 가져오기
            print("start Alamofire")
            switch songArtistSegment.selectedSegmentIndex {
            case 0:
                AF.request("http://www.maniadb.com/api/search/\(searchKeyword)/?sr=song&display=100&key=jgkyj@naver.com&v=0.5", encoding: URLEncoding.httpBody, headers: nil).responseData { [self] (response) in
                    print("response SONG")
                    //song 검색결과에서 데이터 저장
                    if let data = response.data {
                        let xml = XML.parse(data)
                        print("songDataLoaded")
                        //전체 검색 결과가 0개면 출력 안함.
                        //현재 한국어 검색 X, 띄어쓰기 포함하면 X
                        if let totalResult = Int(xml["rss", "channel", "total"].text!), totalResult  != 0{
                            for index in 0...totalResult - 1 {
                                let musicID = xml["rss", "channel", "item", index].attributes["id"]
                                let musicName = xml["rss", "channel", "item", index, "title"].text
                                let artist = xml["rss", "channel", "item", index, "maniadb:artist", "name"].text
                                let id = Int(musicID!)
                                //musicCover가 있으면 넣고 아니면 없게
                                if let musicCover = xml["rss", "channel", "item", index, "maniadb:album", "image"].text{
                                    let url = URL(string: musicCover)
                                    musicData.append(MusicStruct(musicTitle: musicName!, musicArtist: artist!, musicCoverUrl: url!, musicLyrics: nil, musicID: id!))
                                } else {
                                    musicData.append(MusicStruct(musicTitle: musicName!, musicArtist: artist!, musicCoverUrl: nil, musicLyrics: nil, musicID: id!))
                                }
                                //print(musicData[index].musicID)
                            }
                        }
                        tableView.reloadData()
                    }
                }
                
            case 1:
                AF.request("http://www.maniadb.com/api/search/\(searchKeyword)/?sr=artist&display=100&key=jgkyj@naver.com&v=0.5", encoding: URLEncoding.httpBody, headers: nil).responseData { (response) in
                    print("response ARTIST")
                    //artist 검색결과에서 데이터 저장
                    if let data = response.data {
                        let xml = XML.parse(data)
                        print("artistDataLoaded")
                        //구조가 가수가 부른 노래들 여러개 -> 노래 정보를 다시 가져와서 따야됨.
                        //논의 필요!
                    }
                }
            default:
                //segment라서 해당 없음.
                print("nonSelected")
            }
        }
    }//searchButtonPressed
    
}//SearchViewController

//extension SearchViewController (TableView_DataSource)
extension SearchViewController: UITableViewDataSource {
    //numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicData.count
    }//numberOfRowsInSection
    
    //cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //스토리보드의 셀을 형식으로, MusicData의 정보로 셀을 구성. (제목, 제작자, 앨범아트)
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell") as! SearchResultCell
        if musicData.count == 0 {
            return cell
        }
        cell.musicTitle.text = musicData[indexPath.row].musicTitle
        cell.musicArtist.text = musicData[indexPath.row].musicArtist
        do {
            let url = musicData[indexPath.row].musicCoverUrl!
            let data = try Data(contentsOf: url)
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
