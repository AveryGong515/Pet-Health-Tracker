//
//  VaccineLogViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-29.
//

import UIKit

class VaccineLogViewController: ViewController {
    
    var pet: Pet!
    var chosenVaccineName: String?
    @IBOutlet weak var timeStamp: UIDatePicker!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var serialNumberField: UITextField!
    @IBOutlet weak var newVaccineField: UITextField!
    @IBOutlet weak var chooseVaccineButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()

        // Do any additional setup after loading the view.
    }
    
    func configure(){

        self.navigationItem.title = "\(pet.name): Add Vaccine Log"
        chooseVaccineButton.addAction(UIAction(title: "", handler: {(_) in print("vacc selection")}), for: .touchDown)
        newVaccineField.isHidden = true
        chooseVaccineButton.menu = createVaccMenu()
        
        
        
    }
    
    
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        // case 1: new vacc
        if let newVaccine = newVaccineField.text, let serialNumber = serialNumberField.text, !newVaccine.isEmpty, !serialNumber.isEmpty {
            let newVaccLog = LogEntry(id: UUID().uuidString, logTitle: newVaccine, pet: pet, logType: LogType.vaccination.rawValue, timeStamp: timeStamp.date, description: descriptionField.text ?? "", serialID: serialNumber)
            pet.vaccLogNames.append(newVaccine.lowercased())
            pet.save()
            Pet.save(Pet.getPets(), forKey:Pet.petsKey)
            newVaccLog.save()
            LogEntry.save(LogEntry.getLogEntries(), forKey: LogEntry.logEntryKey)
            performSegue(withIdentifier: "unwindToPetProfile", sender: nil)
            
            
        }
        else if let chosenVaccine = chosenVaccineName, let serialNumber = serialNumberField.text, !serialNumber.isEmpty {
            let newVaccLog = LogEntry(id: UUID().uuidString, logTitle: chosenVaccine, pet: pet, logType: LogType.vaccination.rawValue, timeStamp: timeStamp.date, description: descriptionField.text ?? "", serialID: serialNumber)
            newVaccLog.save()
            LogEntry.save(LogEntry.getLogEntries(), forKey: LogEntry.logEntryKey)
            performSegue(withIdentifier: "unwindToPetProfile", sender: nil)
            
            
        }
        else {
            presentAlert(title: "Unable to save log", message: "Please ensure that the vaccine name and serial number are both filled out!")
        }
        
    }
    
    private func createVaccMenu()->UIMenu{
        var vaccOptionsActions = [UIAction]()
        for vacc in pet.vaccLogNames {
            vaccOptionsActions.append(UIAction(title: vacc, handler: chooseVacc))
        }
        vaccOptionsActions.append(UIAction(title: "Add New Vaccination", handler: addNewVacc))
        return UIMenu(title: "Choose Vaccination to Log", options:[.displayInline,.singleSelection], children: vaccOptionsActions)
    }
    
    private func chooseVacc(vacc: UIAction){
        newVaccineField.isHidden = true
        chooseVaccineButton.setTitle(vacc.title, for: .normal)
        chosenVaccineName = vacc.title
        
        
    }
    
    private func addNewVacc(action: UIAction){
        chooseVaccineButton.setTitle(action.title, for: .normal)
        newVaccineField.isHidden = false
        
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
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
