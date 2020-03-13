//
//  Model.swift
//  iOS.Flickr
//
//  Created by Aleksandr Kurdiukov on 07.03.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

import Foundation

class CurrentCamera {
    var name: [String : String]
    var contentName: String {
        return self.name["_content"] ?? ""
    }
    var details: [String : [String : String]]
    var megapixels: String {
        guard let string = self.details["megapixels"]?["_content"]
            else { return "" }
        return "Megapixels: \(string)\n"
    }
    var screen: String {
        guard let string = self.details["lcd_screen_size"]?["_content"]
            else { return "" }
        return "Screen: \(string)\n"
    }
    var memoryType: String {
        guard let string = self.details["memory_type"]?["_content"]
            else { return "" }
        return "Memory Type: \(string)\n"
    }
    var images: [String : [String : String]]
    var imageSmall: String {
        return self.images["small"]?["_content"] ?? ""
    }
    var imageLarge: String {
        return self.images["large"]?["_content"] ?? ""
    }
    
    init?(data: NSDictionary) {
        if let name = data["name"] as? [String : String] {
            self.name = name
        } else { self.name = [:] }
        
        if let details = data["details"] as? [String : [String : String]] {
            self.details = details
        } else { self.details = [:] }
        
        if let images = data["images"] as? [String : [String : String]] {
            self.images = images
        } else { self.images = [:] }
    }
    
    static func createList(json: Any, currentCameras: inout [CurrentCamera]){
        
        if let jsonDict = json as? NSDictionary,
            let cameras = jsonDict["cameras"] as? NSDictionary,
            let list = cameras["camera"] as? [NSDictionary]{
            
            for data in list{
                let currentCamera: CurrentCamera
                currentCamera = CurrentCamera(data: data)!
                currentCameras.append(currentCamera)
            }
        }
    }
}


