//
//  TweetsResponse.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

struct TweetsResponse: Decodable {
    
    // MARK: - Properties
    var tweets: [Tweet] = [Tweet]()

    // MARK: - Enums
    enum CodingKeys: String, CodingKey {
        case tweets = "statuses"
    }

    // MARK: - Decoder for parsing the data into your Custom Model
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            tweets = try values.decode([Tweet].self, forKey: .tweets)
        } catch {
            print("something wrong while parsing response")
        }
    }
}
