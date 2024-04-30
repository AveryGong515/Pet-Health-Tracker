//
//  MedicationComposeViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-28.
//

import UIKit

class MedicationComposeViewController: ViewController {
    
    var pet: Pet!
    
    var logType: String!
    
    var medSelected: String!
    
    var medIsNew: Bool!
    
    var dosageSelected: Float!
    
    var dosageUnitSelected: String!

    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var chooseMedication: UIButton!

    
    @IBOutlet weak var newMed: UITextField!
    
    @IBOutlet weak var dosage: UITextField!

    
    @IBOutlet weak var dosageUnit: UIButton!
    
    @IBOutlet weak var timeStamp: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
        

        // Do any additional setup after loading the view.
    }
    
    
    func configure(){
        self.navigationItem.title = "\(pet.name): Add Med Log"
        timeStamp.maximumDate = Date()
        newMed.isHidden = true
        chooseMedication.addAction(UIAction(title: "", handler: {(_) in print("med selection")}), for: .touchDown)
        chooseMedication.menu = createMedMenu()
        dosageUnit.addAction(UIAction(title: "", handler: {(_) in print("dosage unit selection")}), for: .touchDown)
        dosageUnit.menu = createDosageUnitMenu()
    }
    
    
    private func createMedMenu()->UIMenu{
        var medOptionsActions = [UIAction]()
        for med in pet.medsLogNames {
            medOptionsActions.append(UIAction(title: med, handler: chooseMed))
        }
        medOptionsActions.append(UIAction(title: "Add New Medication", handler: addNewMed))
        return UIMenu(title: "Choose Medication to Log", options:[.displayInline,.singleSelection], children: medOptionsActions)
    }
    
    private func createDosageUnitMenu()->UIMenu{
        var dosageUnitOptionsActions = [UIAction]()
        dosageUnitOptionsActions.append(UIAction(title: "mL", handler: chooseDosageUnit))
        dosageUnitOptionsActions.append(UIAction(title: "mg", handler: chooseDosageUnit))
        return UIMenu(title: "Choose Dosage Unit to Log", options:[.displayInline,.singleSelection], children: dosageUnitOptionsActions)
    }
    
    
    private func chooseDosageUnit(unit: UIAction){
        print("\(unit.title) was chosen as dosage unit")
        dosageUnit.setTitle(unit.title, for: .normal)
        dosageUnitSelected = unit.title
    }
    
    
    private func chooseMed(med: UIAction){
        print("\(med.title) was chosen as medication name")
        chooseMedication.setTitle(med.title, for: .normal)
        newMed.isHidden = true
        medSelected = med.title
        medIsNew = false
        
        
        
    }
    
    private func addNewMed(med: UIAction){
        print("\(med.title) was added as medication name")
        chooseMedication.setTitle("Add New Medication", for: .normal)
        newMed.isHidden = false
        medIsNew = true
        
    }
    

    
    @IBAction func didTapSaveButton(_ sender: Any) {
        print("called")
    
        if let newMedEntered = newMed.text, let dosageEntered = dosage.text, let dosageUnitChosen = dosageUnitSelected, !dosageEntered.isEmpty, !newMedEntered.isEmpty {
            print(dosageEntered, dosageUnitChosen)
            let newMedLog = LogEntry(id: UUID().uuidString, logTitle: newMedEntered, pet: pet, logType: LogType.medication.rawValue, timeStamp: timeStamp.date, description: descriptionField.text  ?? "", dosage: Utils.stringToFloat(str: dosageEntered), dosageUnit: dosageUnitChosen)
            pet.medsLogNames.append(newMedEntered.lowercased())
            pet.save()
            Pet.save(Pet.getPets(), forKey:Pet.petsKey)
            newMedLog.save()
            LogEntry.save(LogEntry.getLogEntries(), forKey: LogEntry.logEntryKey)
            performSegue(withIdentifier: "unwindToPetProfileFromMeds", sender: self)
            
 
            
        }
        
        else if let medChosen = medSelected, let dosageEntered = dosage.text, let dosageUnitChosen = dosageUnitSelected, !medChosen.isEmpty{
            let newMedLog = LogEntry(id: UUID().uuidString, logTitle: medChosen, pet: pet, logType: LogType.medication.rawValue, timeStamp: timeStamp.date, description: descriptionField.text  ?? "", dosage: Utils.stringToFloat(str: dosageEntered), dosageUnit: dosageUnitChosen)
//            pet.save()
//            Pet.save(Pet.getPets(), forKey:Pet.petsKey)
            newMedLog.save()
            LogEntry.save(LogEntry.getLogEntries(), forKey: LogEntry.logEntryKey)
            performSegue(withIdentifier: "unwindToPetProfileFromMeds", sender: self)
          
        }
        else {
            presentAlert(title: "Unable to save log", message: "Please ensure to select or add a medication, dosage, and dosage unit!")
        }

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
    
    
    
    
    
    @IBAction func didTapBackButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToPetProfileFromMeds", sender: nil)
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
