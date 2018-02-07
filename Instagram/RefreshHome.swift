//
//  RefreshHome.swift
//  Instagram
//
//  Created by Harika Lingareddy on 2/6/18.
//  Copyright © 2018 Harika Lingareddy. All rights reserved.
//

import UIKit
import Parse

private let reuseIdentifier = "Cell"

class RefreshHome: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    @IBAction func logoutButtonClicked(_ sender: UIBarButtonItem) {
        PFUser.logOutInBackground { (error: Error?) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
            self.show(loginVC, sender: nil)
        }
    }
    func refresh(_ refreshControl: UIRefreshControl?){
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.whereKey("author", equalTo: PFUser.current()!)
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (postsDict: [PFObject]?, error: Error?) in
            if let postsDict = postsDict {
                // do something with the data fetched
                self.posts = []
                for onePost in postsDict {
                    let post = Post(post: onePost)
                    self.posts.append(post)
                }
                self.postTableView.reloadData()
                if let refreshControl = refreshControl {
                    refreshControl.endRefreshing()
                }
            } else {
                // handle error
            }
        }
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableCell
        
        cell.initWith(post: posts[ indexPath.row ])
        
        return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
