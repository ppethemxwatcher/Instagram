//
//  SettingViewController.swift
//  Instagram
//
//  Created by swiftdev on 2016/03/22.
//  Copyright © 2016年 kiyoko.ohashi. All rights reserved.
//

import UIKit
import Firebase
import ESTabBarController
import SVProgressHUD

class SettingViewController: UIViewController {

    @IBOutlet weak var displayNameTextField: UITextField!
    
    //表示名変更ボタンをタップした時に呼ばれるメソッド
    @IBAction func handleChangeButton(sender: AnyObject) {
        
        if let name = displayNameTextField.text {
            
            //表示名が入力されていない時はHUDを出して何もしない
            if name.characters.isEmpty {
                SVProgressHUD.showErrorWithStatus("表示名を入力してください")
                return
            }
            
            //Firebaseに表示名を保存する
            let usersRef = Firebase(url: CommonConst.FirebaseURL).childByAppendingPath(CommonConst.UsersPATH)
            let data = ["name":name]
            usersRef.childByAppendingPath("/\(usersRef.authData.uid)").setValue(data)
            
            //NSUserDefaultsに表示名を保存する
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setValue(name, forKey: CommonConst.DisplayNameKey)
            ud.synchronize()
            
            //HUDで完了を知らせる
            SVProgressHUD.showSuccessWithStatus("表示名を変更しました")
            
            //キーボードを閉じる
            view.endEditing(true)
            
        }
    }
    
    //ログアウトボタンをタップした時に呼ばれるメソッド
    @IBAction func handleLogoutButton(sender: AnyObject) {
        
        //ログアウトする
        let firebaseRef = Firebase(url: CommonConst.FirebaseURL)
        firebaseRef.unauth()
        
        //ログイン画面を表示する
        let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Login")
        self.presentViewController(loginViewController!, animated: true, completion: nil)
        
        //ログイン画面から戻ってきた時にホーム画面(index = 0)を選択している状態にしておく
        let tabBarController = parentViewController as! ESTabBarController
        tabBarController.setSelectedIndex(0, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NSuserDefaultsから表示名を取得してTextFieldに設定する
        let ud = NSUserDefaults.standardUserDefaults()
        let name = ud.objectForKey(CommonConst.DisplayNameKey) as! String
        displayNameTextField.text = name
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
