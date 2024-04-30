//
//  LogEntryDetailViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-22.
//

import UIKit

class LogEntryDetailViewController: ViewController {
    
    

    @IBOutlet weak var timeStamp: UILabel!
    
    @IBOutlet weak var logName: UILabel!
    @IBOutlet weak var petName: UITextField!
    
    @IBOutlet weak var logType: UITextField!
    
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var entryField2: UITextField!
    @IBOutlet weak var entryField1: UITextField!
    
    var logEntry: LogEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure(with: self.logEntry!)

        // Do any additional setup after loading the view.
    }
    
    func configure(with logEntry: LogEntry){
        logName.text = "Log: \(logEntry.logTitle)"
        petName.text = "Pet: \(logEntry.pet.name)"
        logType.text = "Log entry type: \(logEntry.logType)"
        descriptionField.text = logEntry.description
        timeStamp.text = Utils.formatDateTimetoString(date: logEntry.timeStamp)
        switch logEntry.logType{
        case LogType.symptom.rawValue:
            entryField1.text = "Severity: \(logEntry.severity ?? "None Entered")"
            if let frequency = logEntry.frequency {
                entryField2.text = "Frequency: \(frequency)"
            }
            else {
                entryField2.text = "Frequency: not entered"
            }
            
            break
        case LogType.medication.rawValue:
           
            
            entryField1.text = "Dosage: \(logEntry.dosage ?? 0) \(logEntry.dosageUnit ?? "mL")"
            entryField2.isHidden = true
            
            break
        case LogType.vaccination.rawValue:
            
            entryField1.text = "Serial ID: \(logEntry.serialID ?? "not entered")"
            entryField2.isHidden = true
            break
        default:
            print("invalid LogEntry type")
            break
            
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

}
