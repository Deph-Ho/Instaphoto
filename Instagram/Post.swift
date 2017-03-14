//
//  Post.swift
//  Instagram
//
//  Created by Derek Ho on 3/13/17.
//  Copyright © 2017 Dephanie Ho. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    class func postUserImage(image: UIImage?, caption: String?, withCompletion completion: PFBooleanResultBlock?){
        let post = PFObject(className: "Post")
        let caption = caption ?? "Check out my pic!"
        //add relevant fields to the object
        post["media"] = getImage(image: image)
        post["_p_author"] = PFUser.current()
        post["author"] = PFUser.current()?.username
        post["caption"] = caption
        //post["likesCount"] = 0
        //post["commentsCount"] = 0
        
        //Save object
        post.saveInBackground(block: completion)
    }
    
    class func getImage(image: UIImage?) -> PFFile?{
        if let image = image {
            //get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image){
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
