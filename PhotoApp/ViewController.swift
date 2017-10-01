//
//  ViewController.swift
//  PhotoApp
//
//  Created by Fahim Shahrier Rasel on 30/9/17.
//  Copyright © 2017 Fahim Shahrier Rasel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            for photo in photos {
                print(photo)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

