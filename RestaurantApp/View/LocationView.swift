//
//  LocationView.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 2.01.2023.
//

import UIKit

@IBDesignable class LocationView : MainView {
    
    @IBOutlet weak var allowButton : UIButton!
    @IBOutlet weak var dontAllowButton : UIButton!
    
    var allow : (() -> Void)?
    
    
    @IBAction func handleAllow(_ sender : UIButton) {
        allow?()
        
    }
    
    @IBAction func handleDontAllow(_ sender : UIButton) {
        
    }
    
}
