//
//  PhotoTableViewController.swift
//  PhotoApp
//
//  Created by Fahim Shahrier Rasel on 30/9/17.
//  Copyright © 2017 Fahim Shahrier Rasel. All rights reserved.
//

import UIKit

class PhotoTableViewController: UITableViewController {
    //MARK: Properties
    
    var photos: [Photo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load the sample data
        Photo.photosByCategory("nature", completionHandler: { (results, error) in
            if let error = error {
                // got error in getting the data, need to handle it
                print(error.localizedDescription)
                return
            }
            guard let photos = results else {
                print("Error: Photos are nil")
                return
            }
            self.photos = photos
            
            // Reload the data in main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
            } 
        })

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
        
        // Creating a session object with the default configuration.
        let session = URLSession(configuration: .default)
        
        let pictureDownloadTask = session.dataTask(with: pictureURL) { (data, response, error) in
            if let error = error {
                print("Error downloading picture: \(error)")
            } else {
                // No errors found.
                if let response = response as? HTTPURLResponse {
                    print("Downloaded picture with response code \(response.statusCode)")
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        
                        // Showing the image by main thread
                        DispatchQueue.main.async {
                            cell.previewImage.image = image
                        }
                        
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        pictureDownloadTask.resume()
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
