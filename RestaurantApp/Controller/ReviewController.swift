//
//  CommentController.swift
//  RestaurantApp
//
//  Created by Halil YAŞ on 4.01.2023.
//

import UIKit

class ReviewController: UITableViewController {
    
    //MARK: - Properties
    
    var review : [Review]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return review?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        let comment = review![indexPath.row]
        
        cell.nameLabel.text = comment.user.name
        cell.ratingLabel.text = "Rating : \(comment.rating) / 5"
        cell.commentLabel.text = comment.commentText
        cell.userImage.af_setImage(withURL: comment.user.imageUrl)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
