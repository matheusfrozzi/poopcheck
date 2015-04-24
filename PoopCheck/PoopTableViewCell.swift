//
//  PoopTableViewCell.swift
//  PoopCheck
//
//  Created by Matheus Frozzi Alberton on 23/04/15.
//  Copyright (c) 2015 BEPiD. All rights reserved.
//

import UIKit

class PoopTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var hour: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
