//
//  GroupTableCellProtocol.swift
//  VK-c
//
//  Created by Timur on 06/10/2019.
//  Copyright © 2019 Timur. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewCellProtocol {
    func groupAvatar(url: String) -> UIImage
    func groupName() -> String
    func groupActivity() -> String
    func groupMembersCount() -> String
}


