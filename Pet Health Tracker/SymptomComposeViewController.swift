//
//  SymptomsComposeViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-20.
//

import UIKit

class SymptomComposeViewController: UIViewController {
    
    var pet: Pet!
    var logType: String!
    var isNewSymptom: Bool?
    var severitySelected: String?
    var existingSymptomSelected: String?
    
    
    
    
    @IBOutlet weak var selectSymptom: UIButton!
    @IBOutlet weak var newSymptom: UITextField!
    
    @IBOutlet weak var selectSeverity: UIButton!
    
    @IBOutlet weak var frequencyField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var timeStamp: UIDatePicker!
    
    
    var onComposeLog: ((LogEntry, Pet) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
        
    }
    
    
    @IBAction func didTapSaveButton(_ sender: Any) {

        // check if (either new symptom is added OR selected symptom) AND severity is selected
        if let newSymptomText = newSymptom.text, let severity = severitySelected, !newSymptomText.isEmpty{
            // case 1: new symptom added AND severity selected
//            print("here1")
            let newLog = LogEntry(id: UUID().uuidString, logTitle: newSymptomText, pet: pet, logType: LogType.symptom.rawValue, timeStamp: timeStamp.date, description: descriptionField.text ?? "", severity: severity, frequency: frequencyField.text ?? "")
            pet.symptomLogNames.append(newSymptomText.lowercased())
            pet.save()
            Pet.save(Pet.getPets(), forKey: Pet.petsKey)
            newLog.save()
            LogEntry.save(LogEntry.getLogEntries(), forKey: LogEntry.logEntryKey)
            onComposeLog?(newLog, pet)
            selectSymptom.menu = setSymptomNameMenuOptions()
            performSegue(withIdentifier: "unwindToPetProfile", sender: nil)
        }
        if let symptomName = existingSymptomSelected, let severity = severitySelected {
//            print("here2,\(symptomName)")
            // case 2: existing symptom AND severity selected
            let newLog = LogEntry(id: UUID().uuidString, logTitle: symptomName, pet: pet, logType: LogType.symptom.rawValue, timeStamp: timeStamp.date, description: descriptionField.text ?? "", severity: severity, frequency: frequencyField.text ?? "")
                newLog.save()
                LogEntry.save(LogEntry.getLogEntries(), forKey: LogEntry.logEntryKey)
//            dismiss(animated: true)
            performSegue(withIdentifier: "unwindToPetProfile", sender: nil)
        }
        else {
            presentAlert(title: "Unable to save log", message: "Please ensure to select a symptom and severity!")
        }


       
    }
    
    
    func configure(){
        self.navigationItem.title = "\(pet.name): Add New Log"
        timeStamp.maximumDate = Date()
        newSymptom.isHidden = true
        selectSymptom.addAction(UIAction(title: "", handler: {(_) in print("symptom selection")}), for: .touchDown)
        selectSymptom.menu = setSymptomNameMenuOptions()
        selectSeverity.addAction(UIAction(title: "", handler: {(_) in print("severity selection")}), for: .touchDown)
        selectSeverity.menu = setSeverityMenuOptions()
    }
    
    
    
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func setSymptomNameMenuOptions()->UIMenu{
        var symptomNameOptionsActions = [UIAction]()
        for symptomName in pet.symptomLogNames {
            symptomNameOptionsActions.append(UIAction(title: symptomName, handler: chooseSymptom))
        }
        symptomNameOptionsActions.append(UIAction(title: "Add New Symptom", handler: addNewSymptom))
        return UIMenu(title: "Choose Symptom to Log", options:[.displayInline,.singleSelection], children: symptomNameOptionsActions)
  
    }
    
    func setSeverityMenuOptions()->UIMenu{
        let none = UIAction(title: Severity.none.rawValue, handler: chooseSeverity)
        let mild = UIAction(title: Severity.mild.rawValue, handler: chooseSeverity)
        let moderate = UIAction(title: Severity.moderate.rawValue, handler: chooseSeverity)
        let severe = UIAction(title: Severity.severe.rawValue, handler: chooseSeverity)
        let severityOptionsActions = [none, mild, moderate, severe]
        return UIMenu(title: "Choose severity level of symptom", options:[.displayInline,.singleSelection], children: severityOptionsActions)
        
    }
    
    
    
    
    func chooseSymptom(action: UIAction){
        print("\(action.title) was chosen as symptom name")
        newSymptom.isHidden = true
        isNewSymptom = false
        selectSymptom.setTitle(action.title, for: .normal)
        existingSymptomSelected = action.title
//        symptomSelectedOrAdded = action.title
    }
    
    func chooseSeverity(action: UIAction){
        print("\(action.title) was the severity level chosen for symptom")
        selectSeverity.setTitle(action.title, for: .normal)
        severitySelected = action.title
    }

    func addNewSymptom(action: UIAction){
        print("user wants to add new action")
        selectSymptom.setTitle(action.title, for: .normal)
        newSymptom.isHidden = false
        isNewSymptom = true
//        if let symptomSelectedOrAdded = newSymptom.text {
//        if let symptomSelectedOrAdded = newSymptom.text {
//            print("symptom added: \(symptomSelectedOrAdded)")
//        }
//        else {
//            print("newSymptom.text is nil")
//        }
        
    }

    private func presentAlert(title: String, message: String) {
        // 1.
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        // 2.
        let okAction = UIAlertAction(title: "OK", style: .default)
        // 3.
        alertController.addAction(okAction)
        // 4.
        present(alertController, animated: true)
    }
    

}
