//
//  ChooseLogTypeViewController.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-22.
//

import UIKit

class ChooseLogTypeViewController: ViewController {
    
    var pet: Pet!

    @IBOutlet weak var chooseSymptomLogType: UIButton!
    @IBOutlet weak var chooseVaccinationLogType: UIButton!
    @IBOutlet weak var chooseMedicationLogType: UIButton!
    
//    var onComposeLog:  ((LogEntry) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    
//        configureStyle()

        // Do any additional setup after loading the view.
    }
    
//    func configureStyle(){
//        chooseSymptomLogType.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 16)
//        chooseSymptomLogType.titleLabel?.textColor = .white
//        chooseMedicationLogType.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 16)
//        chooseMedicationLogType.titleLabel?.textColor = .white
//        chooseVaccinationLogType.titleLabel?.font = UIFont(name: "AmericanTypewriter", size: 16)
//        chooseVaccinationLogType.titleLabel?.textColor = .white
//    }
    


    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapSymptomButton(_ sender: Any) {
        performSegue(withIdentifier: "CreateSymptomLogSegue", sender: self.pet)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateSymptomLogSegue"{
            if let logComposeViewController = segue.destination as? LogComposeViewController {
                
//                logComposeViewController.pet = pet
                logComposeViewController.pet = sender as? Pet
                logComposeViewController.logType = LogType.symptom.rawValue
                logComposeViewController.modalPresentationStyle = .fullScreen
                
                

                }
                
            }
        }
        

       
    }
    
    
    
   


