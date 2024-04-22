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
    @IBOutlet weak var isActiveToggle: UIButton!
    
    var onDeactivateButtonTapped: ((Reminder) -> (Void))?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBAction func didTapDeactivateReminderButton(_ sender: Any) {
        
        reminder.isActive = !reminder.isActive
        // get reminder and set it is toggled
//        print("reminder with id \(reminder.id) is active 6: ", reminder.isActive)
        update(with: reminder)
//        print("reminder with id \(reminder.id) is active 7: ", reminder.isActive)
//        self.onDeactivateButtonTapped?(reminder)
        onDeactivateButtonTapped?(reminder)
    }
    
    func configure(with reminder: Reminder, onDeactivateButtonTapped: ((Reminder) -> Void)?){
        self.reminder = reminder
        self.petName.text = reminder.pet.name
        self.dateTime.text = Utils.formatDateTimetoString(date: reminder.dateTime)
        self.reminderName.text = reminder.title
        let imageName = self.reminder.isActive ? "bell" : "bell.slash"
        let image = UIImage(systemName: imageName)
        isActiveToggle.setImage(image, for: .normal)
        
        self.onDeactivateButtonTapped = onDeactivateButtonTapped

        update(with: reminder)

        
    }
    
    private func update(with reminder: Reminder) {
        if reminder.isActive{
            isActiveToggle.setImage(UIImage(systemName: "bell"), for: .normal)
        }
        else {
//            print("reminder with id \(reminder.id) is active 8: ", reminder.isActive)
            isActiveToggle.setImage(UIImage(systemName: "bell.slash"), for: .normal)
//            print("reminder with id \(reminder.id) is active 9: ", reminder.isActive)
            
        }
    }
    
}
