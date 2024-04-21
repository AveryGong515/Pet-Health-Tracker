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
    var petChosen: Pet?
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.layer.cornerRadius = 10
        
        petNameSelectionButton.addAction(UIAction(title: "", handler: {(_) in print("default action")}), for: .touchUpInside)
        petNameSelectionButton.menu = setPetNameMenuOptions()
        
        
        

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
    
    func choosePet(action: UIAction){
        petNameSelectionButton.setTitle(action.title, for: .normal)
        
    }
    
     @IBAction func pickDateTime(_ sender: Any) {
         
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
