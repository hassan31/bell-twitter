//
//  Data++.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-25.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import Foundation

extension Data {
    
    /// Stored property to print nice sanitized debugDescription
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
