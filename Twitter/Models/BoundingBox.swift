//
//  BoundingBox.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-24.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

struct BoundingBox: Decodable {
    
    // MARK: - Properties
    var coordinates: [[[Double]]]?
    
    // MARK: - Enum for defining the keys of your response data
    enum CodingKeys: String, CodingKey {
        case coordinates
    }
    
    // MARK: - Decoder for parsing the data into your Custom Model
    init(from decoder: Decoder) throws {

        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.coordinates = try values.decode([[[Double]]].self, forKey: .coordinates)
        } catch {
            print("BoundingBox - \(error)")
        }
    }
}
