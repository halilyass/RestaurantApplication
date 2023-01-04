//
//  PlacesCell.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 2.01.2023.
//

import UIKit
import AlamofireImage

class PlacesCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet weak var placesImage : UIImageView!
    @IBOutlet weak var locationImage : UIImageView!
    @IBOutlet weak var placesName : UILabel!
    @IBOutlet weak var location : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureUI(restaurant : RestaurantViewModel) {
        
        placesImage.af_setImage(withURL: restaurant.imageUrl)
        placesName.text = restaurant.placeName
        location.text = restaurant.distance
    }

}
