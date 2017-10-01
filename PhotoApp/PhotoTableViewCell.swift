//
//  PhotoTableViewCell.swift
//  PhotoApp
//
//  Created by Fahim Shahrier Rasel on 30/9/17.
//  Copyright © 2017 Fahim Shahrier Rasel. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var likesCounterLabel: UILabel!
    @IBOutlet weak var favoriteCounterLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
