//
//  PhotoTableViewController.swift
//  PhotoApp
//
//  Created by Fahim Shahrier Rasel on 30/9/17.
//  Copyright © 2017 Fahim Shahrier Rasel. All rights reserved.
//

import UIKit
import GameKit
import Alamofire
import SwiftyJSON
import Kingfisher


class PhotoTableViewController: UITableViewController {
    //MARK: Properties
    
    var photos: [Photo] = []
    
    var category: [String] = ["nature", "backgrounds", "science", "education", "health",
                              "places", "animals", "industry", "food", "computer",
                              "sports", "transportaion", "travel", "building", "business"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: category.count)
    
        loadPhotos(forCategory: category[randomNumber])
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.photos.count <= 0 {
            return 0
        }
        
        return self.photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PhotoTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PhotoTableViewCell else {
            fatalError("The dequed cell is not an instance of PhotoTableViewCell")
        }
        
        let photo = photos[indexPath.row]
        
        cell.tagsLabel.text = photo.tags
        cell.likesCounterLabel.text = String(photo.likes)
        cell.favoriteCounterLabel.text = String(photo.favorites)
        
        let pictureURL = URL(string: photo.previewURL)!
        cell.previewImage.kf.setImage(with: pictureURL, placeholder: UIImage(named: "default"))
        

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "ShowWebPhoto" {
            let photoVC = segue.destination as? PhotoViewController
            guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else{
                return
            }
            photoVC?.photoURL = self.photos[indexPath.row].webformatURL
        }
    }
    
    
    // MARK: - Private Methods
    private func loadPhotos(forCategory category: String){
        Alamofire.request(Photo.endpointForCategory(category)).responseJSON { response in
            if let data = response.data{
                let jsonData = JSON(data: data)
                if let hits = jsonData["hits"].arrayObject{
                    for hit in hits {
                        let photo = Photo.init(json: hit as! [String: Any])
                        self.photos.append(photo!)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("Wrong key name")
                }
            }
        }
    }

}
