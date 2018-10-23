//
//  AuthHelpers.swift
//  VK-c
//
//  Created by Timur on 26.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import Foundation

func parse(parameters: String) -> [String: String] {
    
    let params = parameters
        .components(separatedBy: "&")
        .map { $0.components(separatedBy: "=") }
        .reduce([String: String]()) { result, param in
            var dict = result
            let key = param[0]
            let value = param[1]
            dict[key] = value
            return dict
    }
    return params
}
