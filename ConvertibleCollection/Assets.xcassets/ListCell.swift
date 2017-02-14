//
//  ListCell.swift
//  ConvertibleCollection
//
//  Created by Appinventiv on 13/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit


//MARK: Content of List Cell
class ListCell: UICollectionViewCell {
    
    @IBOutlet weak var sampleImage: UIImageView!
    
    
    @IBOutlet weak var sampleLabelText: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Formatting content of List cell
        sampleImage.layer.borderWidth = 2
        sampleImage.layer.borderColor = UIColor.black.cgColor
        sampleImage.layer.cornerRadius = sampleImage.frame.width/4
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        sampleImage.image = nil
        sampleLabelText.text = ""
    }

}
