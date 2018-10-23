//
//  PhotoService.swift
//  VK-c
//
//  Created by Timur on 21/10/2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import Foundation
import UIKit

struct PhotoService {
    
    private let lifeTime: TimeInterval = 7200
    
    static let pathName: String = {
        let pathName = "images"
        guard let c
        
        return pathName
    }()
    
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        let hasheName = String(describing: url.hashValue)
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hasheName).path
    }
    
    
    private func saveImgToCache(url: String, image: UIImage){
        guard let fileName = getFilePath(url: url) else { return }
        let data = UIImagePNGRepresentation(image)
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
}
