//
//  FriendsTVCntr.swift
//  VK-c
//
//  Created by Timur on 26.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import UIKit

class FriendTVCntr: UITableViewController {
    let dp = DataProvider.self
    let api = ApiWrapper.self
    
    
    // для поиска todo
    @IBOutlet weak var searchBarMyFriends: UISearchBar! {
        didSet {
            searchBarMyFriends.delegate = self
        }
    }
    
    var myListFriends = [User]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(refreshDataFriends), for: UIControlEvents.valueChanged)
       
        let friendsRM = dp.getObjects() as [User]
        if (friendsRM.count) > 0 {
            self.myListFriends = friendsRM
        } else {
            refreshDataFriends(sender: self)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func refreshDataFriends(sender: AnyObject){
        print("refresh")
        api.getFriends { (friends) in
            self.dp.saveObjects(friends)
            self.myListFriends = friends
        }
        self.refreshControl?.endRefreshing()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Самые важные"
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return String(myListFriends.count)+" friends"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myListFriends.count
    }
    
    @IBAction func newFriendPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "searchFriend", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsTVCell
        cell.friend = myListFriends[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let friendSend = myListFriends[indexPath.row]
        performSegue(withIdentifier: "friendInfo", sender: friendSend)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "friendInfo", let friendInfo = segue.destination as? FriendInfoVCntr {
            friendInfo.friend = sender as? User
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            myListFriends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}

extension FriendTVCntr: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search")
    }
}

