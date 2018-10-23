//
//  NewsFeedTVCntr.swift
//  VK-c
//
//  Created by Timur on 26.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import UIKit

class NewsFeedTVCntr: UITableViewController {
    let dp = DataProvider.self
    let api = ApiWrapper.self
    var startFrom: String = "0"
    
    var newsFeedList = [NewsModelForCell]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.refreshControl?.addTarget(self, action: #selector(refreshDataNewsFeed), for: UIControlEvents.valueChanged)
        tableView.addSubview(self.refreshControl!)
        
        // todo получение из Realm, если нет то тянем с инета
        refreshDataNewsFeed(sender: self, sF: "0")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func refreshDataNewsFeed(sender: AnyObject, sF: String){
        print("refresh")
        api.getNewsFeed(startFrom: sF, resultCount: 50, completion: { (news, sFrom) in
            self.startFrom = sFrom
            self.newsFeedList = news
        })
        // todo  сохраняем новые данные, предварительно удаляем старые данные
        self.refreshControl?.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        print("did End Displaying Header View")
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        print("scroll")
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        print("did End Displaying Footer View")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsFeedList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsFeedCell", for: indexPath) as! NewsFeedTVCell
        let newsFeed = newsFeedList[indexPath.row]
        cell.newsFeed = newsFeed
        return cell
    }
}
