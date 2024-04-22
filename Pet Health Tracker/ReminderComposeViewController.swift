//
//  ReminderComposeViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-19.
//

import UIKit

class ReminderComposeViewController: UIViewController {

    
    @IBOutlet weak var petNameSelectionButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var reminderTitle: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var petChosen: Pet?
    // define a closure to pass the newly created Reminder around, so that it could be used by ReminderListViewController
    var onComposeReminder: ((Reminder) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.layer.cornerRadius = 10
        
        petNameSelectionButton.addAction(UIAction(title: "", handler: {(_) in print("default action")}), for: .touchDown)
        petNameSelectionButton.menu = setPetNameMenuOptions()
        
        datePicker.minimumDate = Date()
    
        

        // Do any additional setup after loading the view.
    }
    
   

    
    func setPetNameMenuOptions()->UIMenu{
        var petNameOptionsActions = [String]()
        for pet in Pet.getPets(){
            petNameOptionsActions.append(pet.name)
        }
        var actions = [UIAction]()
        for petName in petNameOptionsActions{
            actions.append(UIAction(title: petName, handler: choosePet))
        }
        return UIMenu(title: "Choose Pet Name", options:[.displayInline,.singleSelection], children: actions)
        
        
        
    }
    
    @IBAction func didTapSaveReminderButton(_ sender: Any) {
       
        // check if all required fields are filled out
        if let pet = petChosen, let title = reminderTitle.text, !title.isEmpty{
            // create new Reminder object
            let newReminder = Reminder(id: UUID().uuidString,pet: pet, title: title, description: descriptionTextView.text, dateTime: datePicker.date, isActive: true)
            onComposeReminder?(newReminder)
            dismiss(animated: true)
        }
        else{
            presentAlert(title: "Unable to save reminder", message: "Please ensure to choose a pet and enter a title!")
            
        }
       
        
    }
    
    
    func choosePet(action: UIAction){
        // Set the button title as the pet's name whose been chosen
        petNameSelectionButton.setTitle("Reminder For:  \(action.title)", for: .normal)
        // set the petChosen to be this pet
        petChosen = Pet.getPet(action.title)
        
        
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
    
    
    
     
//     @IBAction func pickDateTime(_ sender: UIDatePicker) {
//     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        
//    }

}
