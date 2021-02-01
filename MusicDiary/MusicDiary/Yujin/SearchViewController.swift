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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
/*
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchResultCell
        cell.songLabel.text = "SongNamePlace"
        cell.artistLabel.text = "\(indexPath.row)"
        
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate{
    
}
*/

class SearchResultViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
