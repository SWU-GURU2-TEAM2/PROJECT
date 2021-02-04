//
//  SearchViewController.swift
//  MusicDiary
//
//  Created by 강유진 on 2021/02/01.
//

import UIKit
import Alamofire
import SwiftyXMLParser
import AlamofireImage

class SearchViewController: UIViewController {
    //values
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var songArtistSegment: UISegmentedControl!
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        
    }
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let size = tableView.frame.size
        if size.height > size.width {
            return size.height / 10
        } else {
            return size.height / 5
        }
        
    }
}


class SearchResultViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
