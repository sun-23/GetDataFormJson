//
//  TableViewCell.swift
//  GetDataOnJson
//
//  Created by sun on 25/4/2562 BE.
//  Copyright © 2562 sun. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var UserLabel: UILabel!
    
    @IBOutlet weak var PasswordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
