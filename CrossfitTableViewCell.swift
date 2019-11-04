//
//  CrossfitTableViewCell.swift
//  Crossfit
//
//  Created by Ana Klabjan on 2/26/19.
//  Copyright © 2019 Ana Klabjan. All rights reserved.
//

import UIKit

class CrossfitTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var lengthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
