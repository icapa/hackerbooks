//
//  BookCellViewTableViewCell.swift
//  HackerBooks
//
//  Created by Iván Cayón Palacio on 5/7/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit

class BookCellViewTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImg: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
