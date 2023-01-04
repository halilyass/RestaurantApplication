//
//  PlacesController.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 2.01.2023.
//

import UIKit

protocol PlacesControllerDelegate : class {
    func selectPlace(viewController : UIViewController, place : RestaurantViewModel)
}

class PlacesController: UITableViewController {
    
    //MARK: - Properties
    
    weak var delegate : PlacesControllerDelegate?
    
    var restaurantList = [RestaurantViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchBar()
        
    }
    
    //MARK: - Helpers
    
    func addSearchBar() {
        
        navigationItem.largeTitleDisplayMode = .always
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.delegate = self
        
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! PlacesCell
        let restaurant = restaurantList[indexPath.row]
        
        cell.configureUI(restaurant: restaurant)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") else { return }
        navigationController?.pushViewController(vc, animated: true)
        let selectedPlace = restaurantList[indexPath.row]
        
        delegate?.selectPlace(viewController: vc, place: selectedPlace)
    }

}

//MARK: - UISearchBarDelegate

extension PlacesController : UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if let search = searchBar.text {
            
            let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
            sceneDelegate.searchFilter = search
            
        }
    }
}
