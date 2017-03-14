//
//  HomeViewController.swift
//  Instagram
//
//  Created by Derek Ho on 3/11/17.
//  Copyright © 2017 Dephanie Ho. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        if let user = PFUser.current(){
            let query = PFQuery(className: "Post")
            query.order(byDescending: "createdAt")
            //query.includeKey(user.username!)
            query.includeKey("author")
            query.limit = 20
            
        //fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error:Error?) in
            if let posts = posts {
                self.posts = posts
                print(posts)
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UserDidLogout"),object: nil)
        }
        self.dismiss(animated: true, completion: nil)
        print("User logged out")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    //Reload the data onto tableview after posting
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = PFUser.current(){
            let query = PFQuery(className: "Post")
            query.order(byDescending: "createdAt")
            //query.includeKey(user.username!)
            query.includeKey("_p_author")
            query.limit = 20
            
            //fetch data asynchronously
            query.findObjectsInBackground { (posts: [PFObject]?, error:Error?) in
                if let posts = posts {
                    self.posts = posts
                    print(posts)
                    self.tableView.reloadData()
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
