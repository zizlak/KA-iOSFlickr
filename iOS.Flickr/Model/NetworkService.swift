//
//  NetworkService.swift
//  iOS.Flickr
//
//  Created by Aleksandr Kurdiukov on 08.03.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

import Foundation
import UIKit

class NetworkService {
    
    static func fetchCameras(camera: String, activityIndicator: UIActivityIndicatorView, completion: @escaping ([CurrentCamera]?) -> Void) {
        
        var currentCameras: [CurrentCamera] = []
        
        let urlString = "https://www.flickr.com/services/rest/?method=flickr.cameras.getBrandModels&api_key=8c2a8d8f1d0317be52d4fb67d8e99ae6&brand=\(camera)&format=json&nojsoncallback=1"
        guard let url = URL(string: urlString) else {activityIndicator.stopAnimating(); return}
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                CurrentCamera.createList(json: json, currentCameras: &currentCameras)
                
                DispatchQueue.main.async {
                    completion(currentCameras)
                }
            }
        }
        task.resume()
    }
}

