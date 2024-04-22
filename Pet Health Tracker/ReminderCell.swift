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
    
    @IBOutlet weak var timeUntil: UILabel!
    
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
        self.timeUntil.text = getTimeUntil(date: reminder.dateTime)
        let imageName = self.reminder.isActive ? "bell" : "bell.slash"
        let image = UIImage(systemName: imageName)
        isActiveToggle.setImage(image, for: .normal)
        
        self.onDeactivateButtonTapped = onDeactivateButtonTapped

        update(with: reminder)

        
    }
    
    private func getTimeUntil(date: Date)->String{
        let calendar = Calendar.current
        let currentDate = Date()
//
        
        if currentDate >= date {
            return "Past Reminder"
        }
        
        let timeComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: currentDate, to: date)
            let years = timeComponents.year ?? 0
            let months = timeComponents.month ?? 0
            let days = timeComponents.day ?? 0
            let hours = timeComponents.hour ?? 0
            let minutes = timeComponents.minute ?? 0
        
         
        if years == 0 && months == 0 && days == 0{
            if hours == 0 && minutes == 0 {
                return "Past Reminder"
            }
            else if hours == 0 {
                return "\(minutes) min"
            }
            else if minutes == 0 {
                return "\(hours) hr"
            }
            return "\(hours) hr, \(minutes) min"
        }
        else if years == 0 && months == 0 && days == 1{
            return "Tomorrow"
        }
        else if years == 0 && months == 0 && days % 7 == 0{
            return "\(days/7) wk"
        }
        else if years == 0 && months == 0{
            return "\(days) d"
        }
        else if years == 0 && days == 0{
            return "\(months) mo"
        }
        else if years == 0{
            return "\(months) mo, \(days) d"
        }
        else{
            return "\(years) yr, \(months) mo, \(days) d"
        }
        
        
       
    }
    
    private func update(with reminder: Reminder) {
        if reminder.isActive{
            isActiveToggle.setImage(UIImage(systemName: "bell"), for: .normal)
            timeUntil.text = getTimeUntil(date: reminder.dateTime)
            timeUntil.textColor = .orange.withAlphaComponent(0.68)
           
        }
        else {
//            print("reminder with id \(reminder.id) is active 8: ", reminder.isActive)
            isActiveToggle.setImage(UIImage(systemName: "bell.slash"), for: .normal)
//            print("reminder with id \(reminder.id) is active 9: ", reminder.isActive)
            timeUntil.text = "reminder inactive"
            timeUntil.textColor = .lightGray
            
        }
    }
    
}
