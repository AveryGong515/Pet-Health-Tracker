//
//  PetCell.swift
//  Pet Health Tracker
//
//  Created by Avery Gong on 2024-04-20.
//

import UIKit

class PetCell: UITableViewCell {
    
    weak var tableView: UITableView?

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var birthDateLabel: UILabel!
    
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
  
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
   
    
    

}
