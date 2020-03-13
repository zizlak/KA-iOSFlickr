//
//  SearchControllerViewElements.swift
//  iOS.Flickr
//
//  Created by Aleksandr Kurdiukov on 13.03.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

import Foundation
import UIKit

class SC_Elements{
    
    // MARK: - Activity Indicator Set up
    
    func setupActivityIndicator(activityIndicator: inout UIActivityIndicatorView, vc: UIViewController){
        activityIndicator = UIActivityIndicatorView(
            frame: CGRect(x: vc.view.frame.width/2 - 150, y: 0, width: 300, height: 300))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        
        vc.view.addSubview(activityIndicator)
    }
    
    // MARK: - ErrorLabel Set up
    
    func setupErrorLabel(label: UILabel, vc: UIViewController){
        label.frame = CGRect(x: 0, y: 20, width: (vc.view.frame.width), height: 100)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "No cameras was found\nTry again"
        vc.view.addSubview(label)
    }
    
    // MARK: - Setup State of Search
    
    enum state {
        case textFieldIsEmpty
        case searching
        case nothingWasFound
        case succeed
    }
    
    func setupState(label: UILabel, activityIndicator: UIActivityIndicatorView, stateOfSearch: state){
        
        switch stateOfSearch {
            
        case .textFieldIsEmpty :
            label.isHidden = true
            activityIndicator.stopAnimating()
        case .searching:
            label.isHidden = true
            activityIndicator.startAnimating()
        case .nothingWasFound:
            label.isHidden = false
            activityIndicator.stopAnimating()
        case .succeed:
            label.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
}
