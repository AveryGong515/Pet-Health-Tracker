//
//  ReminderTableViewCell.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-16.
//

import UIKit

class ReminderCell: UITableViewCell {
    
    var reminder: Reminder!

    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var reminderName: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
