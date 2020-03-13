//
//  TableViewCellSmall.swift
//  iOS.Flickr
//
//  Created by Aleksandr Kurdiukov on 07.03.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

import UIKit

class TableViewCellSmall: UITableViewCell {
    
    @IBOutlet weak var imageViewSmall: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setCell(camera: CurrentCamera){
        titleLabel.text = camera.contentName
        imageViewSmall.setImage(imageURL: camera.imageSmall)
    }
}
