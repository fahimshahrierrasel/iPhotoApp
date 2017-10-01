//
//  PhotoViewController.swift
//  PhotoApp
//
//  Created by Fahim Shahrier Rasel on 1/10/17.
//  Copyright © 2017 Fahim Shahrier Rasel. All rights reserved.
//

import UIKit
import Kingfisher
import UIImageColors

class PhotoViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var webformatImageView: UIImageView!
    
    var photoURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webformatImageView.kf.indicatorType = .activity
        webformatImageView.kf.setImage(with: URL(string: photoURL!), completionHandler: {
            (image, err, cachetype, imageUrl) in
            image?.getColors { colors in
                self.view.backgroundColor = colors.detail
            }
        })
    }
}
