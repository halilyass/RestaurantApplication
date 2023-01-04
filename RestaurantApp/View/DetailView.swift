//
//  DetailView.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 2.01.2023.
//

import Foundation
import UIKit
import MapKit

@IBDesignable class DetailView : MainView {
    
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var timeLabel : UILabel!
    @IBOutlet weak var locationLabel : UILabel!
    @IBOutlet weak var pointLabel : UILabel!
    @IBOutlet weak var mapView : MKMapView!
    
    @IBAction func handleControler(_ sender: UIPageControl) {
        
    }
    
}
