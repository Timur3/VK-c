//
//  AllGroupsTVCntr.swift
//  VK-c
//
//  Created by Timur on 06.08.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import UIKit

class AllGroupsTVCntr: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    var allGroups = [Group]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allGroups", for: indexPath) as! AllGroupsTVCell
        cell.allGroup = allGroups[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let groupSend = allGroups[indexPath.row]
        performSegue(withIdentifier: "searchGroupToGroupInfo", sender: groupSend)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchGroupToGroupInfo", let group = segue.destination as? GroupInfoCntr {
            let g = (sender as? Group)!
            group.groupInfo = g
        }
    }
    
}

extension AllGroupsTVCntr: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            tableView.reloadData()
            return
        }
        ApiWrapper.searchGroups(for: searchText){ (groups) in
            self.allGroups = groups
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        allGroups = []
        tableView.reloadData()
    }
}
