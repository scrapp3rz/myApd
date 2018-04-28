//
//  ModelExtension.swift
//  AppMyDelight
//
//  Created by vincent portier on 24/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import Foundation

extension String {
    
    func codage() -> String {
        return addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? self
    }
    
    func decodage() -> String {
        return removingPercentEncoding ?? self
    }
    
}
