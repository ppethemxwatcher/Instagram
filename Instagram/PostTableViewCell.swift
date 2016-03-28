//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by swiftdev on 2016/03/24.
//  Copyright © 2016年 kiyoko.ohashi. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    
    var postData: PostData?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //表示される時に呼ばれるメソッドをオーバーライドしてデータをUIに反映する
    override func layoutSubviews() {
        
        postImageView.image = postData!.image
        captionLabel.text = "\(postData!.name!):\(postData!.caption!)"
        
        let likeNumber = postData!.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja-JP")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString: String = formatter.stringFromDate(postData!.date!)
        dateLabel.text = dateString
        
        if postData!.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
        likeButton.setImage(buttonImage, forState: UIControlState.Normal)
        }
        
        //コメントが入ったら投稿者の名前とコメントを改行しながら追加
        commentLabel.text = ""
        for var commentData = 0; commentData < postData!.comment.count; commentData++    {
            if commentData > 0 {
                commentLabel.text = commentLabel.text! + "\n"
            }
            commentLabel.text! = commentLabel.text! + "\(postData!.followername[commentData]): \(postData!.comment[commentData])"
        }
        
        super.layoutSubviews()
    }
}
