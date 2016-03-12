//
//  EventTableViewCell.swift
//  Hw2
//
//  Created by Dylan Homuth on 3/11/16.
//  Copyright © 2016 Dylan Homuth. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    //properties
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var dateLab: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
