//
//  PhotoCell.swift
//  Instagram
//
//  Created by Dephanie Ho on 3/13/17.
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
    
    var likeCounter = 0
    
    var post: PFObject!{
        didSet{
           descriptionTextField.text = post["caption"] as? String
           userLabel.text = post["author"] as? String
           likesCount.text = String(likeCounter)
        
           if let photoImageView = post["media"] as? PFFile{
                photoImageView.getDataInBackground({ (imageData:Data?, error:Error?) in
                if let imageData = imageData{
                    self.photoImageView.image = UIImage(data: imageData)
                }
            })
        }
    }
}
    @IBAction func onFavorite(_ sender: UIButton) {
        if(sender.isSelected){
            //deselect button
            sender.isSelected = false
            likesCount.text = String(likeCounter)
            self.favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: UIControlState())
        } else {
            //selected button
            sender.isSelected = true
            likeCounter += 1
            likesCount.text = String(likeCounter)
            self.favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState())
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
