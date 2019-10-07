//
//  PhotoProtocol.swift
//  VK-c
//
//  Created by Timur on 04/10/2019.
//  Copyright © 2019 Timur. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoProtocol {
    var lifeTime: TimeInterval { get }
    var pathName: String { get }

    func getFilePath(url: String) -> String?
    func saveImgToCache(url: String, image: UIImage)
}
