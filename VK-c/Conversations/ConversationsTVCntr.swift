//
//  MessagesTVCntr.swift
//  VK-c
//
//  Created by Timur on 14.08.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import UIKit

class ConversationsTVCntr: UITableViewController {
    
    let api = MessageApi.self
    var users = [User]()
    var groups = [Group]()
    var msgMain: ResponseConversationsRoot?
    var myMessages = [ConversationAndLastMessage]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(refreshDataFriends), for: UIControlEvents.valueChanged)
        
        //let friendsRM = dp.getObjects() as [User]
        //if (friendsRM.count) > 0 {
          //  self.myListFriends = friendsRM
        //} else {
            refreshDataFriends(sender: self)
        //}
        
        tableView.delegate = self
        tableView.dataSource = self
        
        }
        
        @objc func refreshDataFriends(sender: AnyObject){
            print("refresh")
            api.getConversations { (messages) in
                self.msgMain = messages
                //print(messages)
                self.myMessages = messages.responseConversationsRoot.conversations
                self.users = messages.responseConversationsRoot.users
                self.groups = messages.responseConversationsRoot.groups
                
            self.refreshControl?.endRefreshing()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return myMessages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "conversationsCell", for: indexPath) as! ConversationsTVCell
        let model = myMessages[indexPath.row]
        cell.conversation = CreateConversationModelForCell(model, u: self.users, g: self.groups)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let conversationSend = myMessages[indexPath.row]
        performSegue(withIdentifier: "conversationWithFriend", sender: conversationSend)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "conversationWithFriend", let conversation = segue.destination as? ConversationFriendTVCntr {
           // let c = (sender as? ConversationModelForCell)!
            //conversation.convenienceModelCell = c
        }
    }

}
