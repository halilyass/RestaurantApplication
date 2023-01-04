//
//  NetworkService.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 3.01.2023.
//

import Foundation
import Moya

private let apiKey = "ztnHhUlipIvMVSKuFB8ICIy6DlUUIc373WmUIlN2AfmMcg7KufQG5rk1DOB_SxAGIQrygB7es12T6T7GX38lYl05dfUCD0wPf7O_DBhdp_MXJxn9EkiyCM8I55T6XHYx"

enum YelpService {
    
    enum DataProvider : TargetType {
        
        case search(lat : Double, long : Double)
        case details(id : String)
        case searchFilter(lat : Double, long : Double, filter : String)
        case reviews(id : String)
        
        var baseURL: URL {
            return URL(string:"https://api.yelp.com/v3/businesses")!
        }
        
        var path: String {
            switch self {
            case.search : return "/search"
            case.details(let id) : return "/\(id)"
            case.searchFilter : return "/search"
            case.reviews(let id) : return "/\(id)/reviews"
                
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var sampleData: Data {
            return Data()
        }
        
        var task: Moya.Task {
            switch self {
                
            case let .search(lat, long) :
                return .requestParameters(parameters: ["latitude": lat, "longitude" : long, "limit" : 20, "radius" : 40000], encoding: URLEncoding.queryString)
                
            case let .details(id) : return.requestPlain
                
            case let .searchFilter(lat, long, filter) :
                return .requestParameters(parameters: ["latitude": lat, "longitude" : long, "limit" : 20,"term" : filter, "radius" : 40000], encoding: URLEncoding.queryString)
                
            case.reviews(let id) :
                return .requestPlain
            }
        }
        
        var headers: [String : String]? {
            return ["Authorization" : "Bearer \(apiKey)"]
        }
    }
}
