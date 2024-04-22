//
//  ReminderDetailViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-21.
//

import UIKit

class ReminderDetailViewController: ViewController {

    var reminder: Reminder!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reminderTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setReminderDetailView()

        // Do any additional setup after loading the view.
    }
    
    func setReminderDetailView(){
        descriptionField.text = reminder.description
        nameLabel.text = reminder.pet.name
        reminderTitle.text = reminder.title
        dateTimeLabel.text = Utils.formatDateTimetoString(date: reminder.dateTime)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
