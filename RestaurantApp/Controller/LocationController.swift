//
//  LocationController.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 2.01.2023.
//

import UIKit

protocol LocationControllerDelegate : class {
    func allow()
}

class LocationController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var locationView : LocationView!
    
    weak var delegate : LocationControllerDelegate?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationView.allow = {
            self.delegate?.allow()
        }
        
        
    }
}
