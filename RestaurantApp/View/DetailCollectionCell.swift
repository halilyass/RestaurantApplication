//
//  DetailCollectionCell.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 4.01.2023.
//

import UIKit

class DetailCollectionCell: UICollectionViewCell {
    
    let placeImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    func configure() {
        contentView.addSubview(placeImage)
        placeImage.translatesAutoresizingMaskIntoConstraints = false
        placeImage.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
        
            placeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            placeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placeImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            placeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        ])
    }
    
}
