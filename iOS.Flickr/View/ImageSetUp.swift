//
//  ImageSetUp.swift
//  iOS.Flickr
//
//  Created by Aleksandr Kurdiukov on 11.03.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(imageURL: String?) {
        
        guard let url = URL(string: imageURL ?? "") else {
            self.image = nil
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) {  (data, response, error) in
            
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        dataTask.resume()
    }
}
