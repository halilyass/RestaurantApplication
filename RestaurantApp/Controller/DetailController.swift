//
//  DetailController.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 2.01.2023.
//

import UIKit
import AlamofireImage
import MapKit
import CoreLocation

protocol DetailControllerDelegate : class {
    func getComment(viewController : UIViewController, placeId : String)
}

class DetailController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate : DetailControllerDelegate?
    
    @IBOutlet weak var detailView : DetailView!
    
    var restaurantDetail : DetailsViewModel? {
        didSet { configureUI() }
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.collectionView.register(DetailCollectionCell.self, forCellWithReuseIdentifier: "DetailCollectionCell")
        detailView.collectionView.delegate = self
        detailView.collectionView.dataSource = self

    }
    
    //MARK: - Actions
    
    
    @IBAction func clickedGetComment(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ReviewController") else { return }
        navigationController?.pushViewController(vc, animated: true)
        delegate?.getComment(viewController: vc, placeId: restaurantDetail!.id)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        
        detailView.pointLabel.text = restaurantDetail?.rating
        detailView.timeLabel.text = restaurantDetail?.isClosed
        detailView.priceLabel.text = restaurantDetail?.price
        detailView.locationLabel.text = restaurantDetail?.phoneNumber
        
        detailView.collectionView.reloadData()
        showMap()
        title = restaurantDetail?.placeName
    }
    
    func showMap() {
        
        if let coordinate = restaurantDetail?.coordinates {
            
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            detailView.mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = restaurantDetail?.placeName
            detailView.mapView.addAnnotation(annotation)
            
        }
        
    }
    
}

//MARK: - UICollectionViewDelegate

extension DetailController : UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDataSource

extension DetailController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantDetail?.restaurantImages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionCell", for: indexPath) as! DetailCollectionCell
        
        if let imageUrl = restaurantDetail?.restaurantImages[indexPath.row] {
            cell.placeImage.af_setImage(withURL: imageUrl)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        detailView.pageControl.currentPage = indexPath.row
    }
}

//MARK: - UICollectionViewFlowLayout

extension DetailController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
