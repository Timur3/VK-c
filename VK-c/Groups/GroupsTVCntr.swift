//
//  GroupsTVCntr.swift
//  VK-c
//
//  Created by Timur on 29.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import UIKit

class GroupsTVCntr: UITableViewController {

    let dp = DataProvider.self
    
    var myGroups = [Group]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        self.refreshControl?.addTarget(self, action: #selector(refreshDataGroups), for: UIControlEvents.valueChanged)
        
        let groupsRM = dp.getObjects() as [Group]
        if (groupsRM.count) > 0 {
            self.myGroups = groupsRM
        } else {
            refreshDataGroups(sender: self)
            
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func refreshDataGroups(sender: AnyObject){
        print("refresh")
        ApiWrapper.getGroups { (groups) in
            self.dp.saveObjects(groups)
            self.myGroups = groups
        }
        self.refreshControl?.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewGroupPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addNewGroup", sender: nil)
    }
    
    // MARK: - Table view data source
    // set view for footer
    /*override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
     let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
     footerView.backgroundColor = UIColor.blue
     return footerView
     }
     
     // set height for footer
     override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
     return 40
     }*/
    
    override func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        print("did End Displaying Header View")
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scroll")
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        print("did End Displaying Footer View")
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("1")
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return String(myGroups.count)+" groups"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myGroupsCell", for: indexPath) as! GroupsTVCell
        cell.group = myGroups[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let groupSend = myGroups[indexPath.row]
        print(groupSend.id)
        performSegue(withIdentifier: "groupInfo", sender: groupSend)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "groupInfo", let group = segue.destination as? GroupInfoCntr {
            let g = (sender as? Group)!
            group.groupInfo = g
            print(g.id)
        }
    }
    
}
