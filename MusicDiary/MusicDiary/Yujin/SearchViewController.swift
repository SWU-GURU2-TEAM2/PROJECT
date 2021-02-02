//
//  SearchViewController.swift
//  MusicDiary
//
//  Created by 강유진 on 2021/02/01.
//

import UIKit
import Alamofire
import SwiftyXMLParser

class SearchViewController: UIViewController {
    
    //values
    var searchKeyword: String = ""
    @IBOutlet weak var searchTextField: UITextField! //searchTextField
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        guard let searchValue = searchTextField.text, searchValue != "" else {
            return
        }
        self.searchKeyword = searchValue
        print(searchKeyword)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchResultCell
        cell.songName.text = "Lover"
        cell.artist.text = "TaylorSwift"
        let url = URL(string: "https://i.pinimg.com/originals/5b/90/6e/5b906ef12a8dc0c15b76a55ffeb9a6b5.jpg")
        do {
            let data = try Data(contentsOf: url!)
            cell.albumImage.image = UIImage(data: data)
        } catch {
            cell.albumImage.image = UIImage(named: "sampleAlbumImage")
        }
        let height = tableView.frame.height / 12
        cell.albumImage.sizeThatFits(CGSize(width: height, height: height))
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height / 11
        return height
    }
    
    
}

class SearchResultViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
