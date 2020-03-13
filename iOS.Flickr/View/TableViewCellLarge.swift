//
//  TableViewCellLarge.swift
//  iOS.Flickr
//
//  Created by Aleksandr Kurdiukov on 07.03.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

import UIKit

class TableViewCellLarge: UITableViewCell {
    
    @IBOutlet weak var imageViewLarge: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    func setCell(camera: CurrentCamera){
        
        titleLabel.text = camera.contentName
        detailsLabel.text = camera.megapixels + camera.screen + camera.memoryType
        imageViewLarge.setImage(imageURL: camera.imageLarge)
    }
}
