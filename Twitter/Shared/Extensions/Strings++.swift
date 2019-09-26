//
//  Strings++.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

extension String {
    
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
    func urlEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
