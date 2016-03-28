//
//  CommentPostViewController.swift
//  Instagram
//
//  Created by swiftdev on 2016/03/28.
//  Copyright © 2016年 kiyoko.ohashi. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentPostViewController: UIViewController {

    @IBOutlet weak var commentTextField: UITextField!
    
    var post = PostData!()

    //コメント投稿ボタンをタップした時に呼ばれるメソッド
    @IBAction func handleCommentPostButton(sender: AnyObject) {
        
        let postData = self.post
        postData.comment.append(commentTextField.text!)
        let name = postData.name
        let imageString = postData.imageString
        let caption = postData.caption
        let time = (postData.date?.timeIntervalSinceReferenceDate)! as NSTimeInterval
        let likes = postData.likes
        let comment = postData.comment
        var followername = postData.followername
        
        let ud = NSUserDefaults.standardUserDefaults()
        let userName = ud.objectForKey(CommonConst.DisplayNameKey) as! String
            followername.append(userName)
        
        let post = ["caption": caption!, "image": imageString!, "name": name!, "time": time, "likes": likes, "comment": comment, "followername": followername]
        let postRef = Firebase(url: CommonConst.FirebaseURL).childByAppendingPath(CommonConst.PostPATH)
        postRef.childByAppendingPath(postData.id).setValue(post)
    
    //HUDで投稿完了を表示する
    SVProgressHUD.showSuccessWithStatus("投稿しました")
    
    //全てのモーダルを閉じる
    UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true,completion: nil)
    }
    
    //キャンセルボタンをタップした時に呼ばれるメソッド
    @IBAction func handleCancelPostButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
