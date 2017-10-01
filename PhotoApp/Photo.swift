//
//  Photo.swift
//  PhotoApp
//
//  Created by Fahim Shahrier Rasel on 30/9/17.
//  Copyright © 2017 Fahim Shahrier Rasel. All rights reserved.
//
import Foundation
import SwiftyJSON

struct Photo{
    let id: Int
    let likes: Int
    let favorites: Int
    let tags: String
    let imageWidth: Int
    let imageHeight: Int
    let previewURL: String
    let webformatURL: String
    
//    init?(json: SwiftyJSON.JSON){
//        self.id = json["id"].int!
//        self.likes = json["likes"].int!
//        self.favorites = json["favorites"].int!
//        self.tags = json["tags"].string!
//        self.imageWidth = json["imageWidth"].int!
//        self.imageHeight = json["imageHeight"].int!
//        self.previewURL = json["previewURL"].string!
//        self.webformatURL = json["webformatURL"].string!
//    }
    
    init?(json: [String: Any]){

        guard let id = json["id"] as? Int,
            let likes = json["likes"] as? Int,
            let favorites = json["favorites"] as? Int,
            let tags = json["tags"] as? String,
            let imageWidth = json["imageWidth"] as? Int,
            let imageHeight = json["imageHeight"] as? Int,
            let previewURL = json["previewURL"] as? String,
            let webformatURL = json["webformatURL"] as? String
            else{
                return nil
        }
        self.id = id
        self.likes = likes
        self.favorites = favorites
        self.tags = tags
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.previewURL = previewURL
        self.webformatURL = webformatURL

    }
    
    enum BackendError: Error{
        case urlError(reason: String)
        case objectSerialization(reason: String)
    }
    
    static func endpointForCategory(_ category: String) -> String {
        return "https://pixabay.com/api/?key=6582767-4a7c93bb6669d3b9e20026474&category=\(category)&image_type=photo"
    }


//    static func photosByCategory(_ category: String, completionHandler: @escaping([Photo]?, Error?) -> Void){
//
//        var allPhotos: [Photo] = []
//
//        // set up URLRequest with URL
//        let endpoint = Photo.endpointForCategory(category)
//
//        guard let url = URL(string: endpoint) else {
//            print("Error: cann't create URL")
//            let error = BackendError.urlError(reason: "Could not construct URL")
//            completionHandler(nil, error)
//            return
//        }
//        let urlRequest = URLRequest(url: url)
//
//        // Make Request
//        let sesssion = URLSession.shared
//        let task = sesssion.dataTask(with: urlRequest, completionHandler:
//        { (data, response, error) in
//            // handle response to request
//
//            // check for error
//            guard error == nil else {
//                completionHandler(nil, error!)
//                return
//            }
//
//            // make sure data in the response
//            guard let data = data else {
//                print("Error: didn't receive data")
//                let error = BackendError.objectSerialization(reason: "No data in response")
//                completionHandler(nil, error)
//                return
//            }
//
//            // parse the result as JSON
//            // then create a Photo from the JSON
//            do{
//
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let photos = json["hits"] as? [[String: Any]] {
//
//                    for photo in photos{
//                        allPhotos.append(Photo(json: photo)!)
//                    }
//                    completionHandler(allPhotos, nil)
//
//                } else {
//                    // could not
//                    print("Error: Could not create photo object")
//                    let error = BackendError.objectSerialization(reason: "Couldn't create a Photo Array from the JSON")
//                    completionHandler(nil, error)
//                }
//
//            } catch{
//                // error trying to convert the data to JSON using JSONSerialization.jsonObject
//                completionHandler(nil, error)
//                return
//            }
//
//        })
//
//        task.resume()
//    }

    
//    static func getPhotoByCatagory(_ category: String) -> [Photo] {
//        Alamofire.request(endpointForCategory("nature")).responseJSON { response in
//            if let jsonData = response.result.value {
//                print("JSON: \(jsonData)")
//            }
//        }
//        return []
//    }
    
    
}
