//
//  PhotoCell.swift
//  Instagram
//
//  Created by Derek Ho on 3/13/17.
//  Copyright © 2017 Dephanie Ho. All rights reserved.
//

import UIKit
import Parse

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    var post: PFObject!{
        didSet{
           descriptionTextField.text = post["caption"] as? String
            userLabel.text = post["author"] as? String
            if let photoImageView = post["media"] as? PFFile{
                photoImageView.getDataInBackground({ (imageData:Data?, error:Error?) in
                    if let imageData = imageData{
                        self.photoImageView.image = UIImage(data: imageData)
                    }
                })
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
