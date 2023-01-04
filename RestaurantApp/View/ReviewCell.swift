//
//  CommentCell.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 4.01.2023.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    //MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
