//
//  MemoTableViewCell.swift
//  Kiroku
//
//  Created by Aoi Sakaue on 2017/02/22.
//  Copyright © 2017年 Sakaue Aoi. All rights reserved.
//

import UIKit

class MemoTableViewCell: UITableViewCell {

    @IBOutlet var memoLabel :UILabel!
    @IBOutlet var dateLabel :UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
