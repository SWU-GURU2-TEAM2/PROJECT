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
    
    @IBOutlet weak var searchTextFied: UITextField!
    @IBOutlet weak var songArtistSegment: UISegmentedControl!
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
        return cell
        
    }
    
}

extension SearchViewController: UITableViewDelegate{
    
}


class SearchResultViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
