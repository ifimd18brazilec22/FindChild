//
//  KidsTableViewCell.swift
//  FindChild
//
//  Created by Malik on 27.10.2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import UIKit

class KidsTableViewCell: UITableViewCell {

    @IBOutlet weak var kidName: UILabel!
    @IBOutlet weak var kidImage: UIImageView!
    @IBOutlet weak var kidCall: UIButton!
    @IBOutlet weak var kidLocation: UILabel!
    
    @IBAction func kidCall(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
