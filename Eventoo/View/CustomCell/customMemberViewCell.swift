//
//  customMemberViewCell.swift
//  Eventoo
//
//  Created by Ridwan Abdurrasyid on 27/04/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit

class customMemberViewCell: UICollectionViewCell {

    @IBOutlet weak var initialLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialLabel.layer.cornerRadius = initialLabel.layer.borderWidth/3
        initialLabel.textAlignment = .center
        // Initialization code
    }
    
    func setInitial (initial : String){
        initialLabel.text = initial
    }

}
