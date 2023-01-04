//
//  SceneDelegate.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 2.01.2023.
//

import UIKit
import Moya
import CoreLocation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    //MARK: - Properties

    var window: UIWindow?
    var locationService = LocationService()
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    let decoder = JSONDecoder()

    let networkService = MoyaProvider<YelpService.DataProvider>()
    
    var navigationController : UINavigationController?
    
    var searchFilter : String? {
        didSet {
            if self.searchFilter!.isEmpty {
                self.getPlace(coordinate: locationService.selectedLocation!)
            } else {
                self.placeSearch(coordinate: locationService.selectedLocation!, searchFilter: self.searchFilter!)
            }
        }
    }
    
    //MARK: - Helpers

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        locationService.newLocation = { result in
            switch result {
            case .successful(let locationInfo) :
                
                //print(locationInfo.coordinate.latitude,"-",locationInfo.coordinate.longitude)
                self.getPlace(coordinate: locationInfo.coordinate)
                
            case .incorrent(let error) :
                
                //assertionFailure("Error : \(error)")
                print("DEBUG: Error")
            }
        }
        
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        
        switch locationService.status {
        case .denied , .notDetermined , .restricted :
            
            guard let vc = storyBoard.instantiateViewController(withIdentifier: "LocationController") as? LocationController else { return }
            vc.delegate = self
            self.window?.rootViewController = vc
        default :
            
            let navigation = storyBoard.instantiateViewController(withIdentifier: "PlacesNavigationController") as? UINavigationController
            self.window?.rootViewController = navigation
            navigationController = navigation
            locationService.getLocation()
            (navigation?.topViewController as? PlacesController)?.delegate = self
            
        }
        self.window?.makeKeyAndVisible()
        
    }
    
    private func getDetail(viewController : UIViewController, placeId: String) {
        networkService.request(.details(id: placeId)) { result in
            switch result {
            case.success(let data) :
                
                if let detail = try? self.decoder.decode(Details.self, from: data.data) {
                    
                    let restaurantDetail = DetailsViewModel(detail: detail)
                    let vc = (viewController as? DetailController)
                    vc?.restaurantDetail = restaurantDetail
                    vc?.delegate = self
                }
                
            case.failure(let error) :
                print("DEBUG: Error \(error)")
            }
        }
    }
    
    private func getPlace(coordinate : CLLocationCoordinate2D) {
        networkService.request(.search(lat: coordinate.latitude, long: coordinate.longitude)) { result in
            switch result {
            case .success(let getData) :
                
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try? self.decoder.decode(AllData.self, from: getData.data)
                let placesList = data?.businesses.compactMap(RestaurantViewModel.init).sorted(by: { $0.distance < $1.distance })
                
                if let navigation = self.window?.rootViewController as? UINavigationController, let placesController = navigation.topViewController as? PlacesController {
                    
                    placesController.restaurantList = placesList ?? []
                } else if let navgation1 = self.storyBoard.instantiateViewController(withIdentifier: "PlacesNavigationController") as? UINavigationController {
                    
                    self.navigationController = navgation1
                    navgation1.modalPresentationStyle = .fullScreen
                    self.window?.rootViewController?.present(navgation1, animated: true,completion: {
                        (navgation1.topViewController as? PlacesController)?.delegate = self
                        (navgation1.topViewController as? PlacesController)?.restaurantList = placesList ?? []
                    })
                }
                
            case .failure(let error) :
                print("DEBUG: Error ----> \(error)")
            }
        }
    }
    
    private func placeSearch(coordinate : CLLocationCoordinate2D, searchFilter : String) {
        networkService.request(.searchFilter(lat: coordinate.latitude, long: coordinate.longitude,filter: searchFilter)) { result in
            switch result {
            case .success(let getData) :
                
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try? self.decoder.decode(AllData.self, from: getData.data)
                let placesList = data?.businesses.compactMap(RestaurantViewModel.init).sorted(by: { $0.distance < $1.distance })
                
                if let navigation = self.window?.rootViewController as? UINavigationController, let placesController = navigation.topViewController as? PlacesController {
                    
                    placesController.restaurantList = placesList ?? []
                } else if let navgation1 = self.storyBoard.instantiateViewController(withIdentifier: "PlacesNavigationController") as? UINavigationController {
                    
                    self.navigationController = navgation1
                    navgation1.modalPresentationStyle = .fullScreen
                    self.window?.rootViewController?.present(navgation1, animated: true,completion: {
                        (navgation1.topViewController as? PlacesController)?.delegate = self
                        (navgation1.topViewController as? PlacesController)?.restaurantList = placesList ?? []
                    })
                }
                
            case .failure(let error) :
                print("DEBUG: Error ----> \(error)")
            }
        }
    }
    
    func getComments(viewController : UIViewController, placeId : String) {
        
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        networkService.request(.reviews(id: placeId)) { result in
            
            switch result {
                
            case.success(let data) :
                
                if let comment = try? self.decoder.decode(Response.self, from: data.data) {
                    
                    print("DEBUG: ---------> \(comment)")
                    
                } else {
                    print("DEBUG: ERROR")
                }
                
            case.failure(let error) :
                print("DEBUG: Error \(error)")
            }
            
        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

//MARK: - LocationControllerDelegate

extension SceneDelegate : LocationControllerDelegate {
    
    func allow() {
        locationService.request()
    }
}

//MARK: - PlacesControllerDelegate

extension SceneDelegate : PlacesControllerDelegate {
    
    func selectPlace(viewController: UIViewController, place: RestaurantViewModel) {
        getDetail(viewController: viewController, placeId: place.id)
    }
}

//MARK: - DetailControllerDelegate

extension SceneDelegate : DetailControllerDelegate {
    
    func getComment(viewController: UIViewController, placeId: String) {
        self.getComments(viewController: viewController, placeId: placeId)
    }
}

