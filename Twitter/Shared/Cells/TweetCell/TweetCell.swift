//
//  TweetCell.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDisplayName: UILabel!
    @IBOutlet weak var lblTweet: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        
        super.awakeFromNib()
        ivProfile.setRoundCorner()
        containerView.setCornerRadius(5)
    }
}

// MARK: - Configure Cell Protocol Methods
extension TweetCell: ConfigureCell {
    
    typealias T = Tweet
    
    func configureCell(_ data: Tweet) {
        
        lblName.text = data.name
        lblDisplayName.text =  "@" + (data.displayName ?? "")
        lblTweet.text = data.text
        
        ivProfile.loadImage(url: URL(string: data.profileImage ?? "")!)
    }
}
