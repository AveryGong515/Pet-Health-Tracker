//
//  ReminderListViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-19.
//

import UIKit

class ReminderListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var reminders = [Reminder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        tableView.tableHeaderView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        refreshReminders()
        
        
    }
    
    
    
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as! ReminderCell
        let reminder = reminders[indexPath.row]
        cell.petName.text = reminder.pet.name
        cell.dateTime.text = Utils.formatDateTimetoString(date: reminder.dateTime)
        cell.reminderName.text = reminder.title
//        cell.isActiveToggle.isOn = reminder.isActive
        // implement cell.configure later
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewReminderDetailSegue"{
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else {return}
            let selectedReminder = reminders[selectedIndexPath.row]
            guard let reminderDetailViewController = segue.destination as? ReminderDetailViewController else {return}
            reminderDetailViewController.reminder = selectedReminder
                    
                
            }
        
        if segue.identifier == "ComposeReminderSegue"{
            if let reminderComposeViewController = segue.destination as? ReminderComposeViewController {
                reminderComposeViewController.onComposeReminder = { [weak self] reminder in
                    reminder.save()
                    self?.refreshReminders()
                    
                }
            }
        }
        else {
            print("bad request")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row after tapping
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    func refreshReminders(){
        var reminders = Reminder.getReminders()
        for reminder in reminders{
            print(reminder.title, reminder.pet.name)
        }
//
        // 2.
        self.reminders = reminders
//
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


