//
//  LogEntryCell.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-22.
//

import UIKit

class LogEntryCell: UITableViewCell {

    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var logTypeSymbol: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
