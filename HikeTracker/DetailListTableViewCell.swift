//
//  DetailListTableViewCell.swift
//  HikeTracker
//
//  Created by James Hadar on 4/7/20.
//  Copyright © 2020 Sam Hoidal. All rights reserved.
//

import UIKit

class DetailListTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
