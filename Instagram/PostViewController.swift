//
//  PostViewController.swift
//  Instagram
//
//  Created by swiftdev on 2016/03/22.
//  Copyright © 2016年 kiyoko.ohashi. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class PostViewController: UIViewController {
    
    var image: UIImage!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    //投稿ボタンをタップした時に呼ばれるメソッド
    @IBAction func handlePostButton(sender: UIButton) {
        
        let postRef = Firebase(url: CommonConst.FirebaseURL).childByAppendingPath(CommonConst.PostPATH)
        
        //imageViewから画像を取得する
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.5)
        
        //NSUserDefaultsから表示名を取得する
        let ud = NSUserDefaults.standardUserDefaults()
        let name = ud.objectForKey(CommonConst.DisplayNameKey) as! String
        
        //時間を取得する
        let time = NSDate.timeIntervalSinceReferenceDate()
        
        //辞書を作成してFirebaseに保存する
        let postData = ["caption": textField.text!, "image": imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength), "name": name, "time": time]
        postRef.childByAutoId().setValue(postData)
        
        //HUDで投稿完了を表示する
        SVProgressHUD.showSuccessWithStatus("投稿しました")
        
        //全てのモーダルを閉じる
        UIApplication.sharedApplication().keyWindow?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //キャンセルボタンをタップした時に呼ばれるメソッド
    @IBAction func handleCancelButton(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //受け取った画像をImageViewに設定する
        imageView.image = image

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
