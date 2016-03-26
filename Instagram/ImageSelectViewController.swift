//
//  ImageSelectViewController.swift
//  Instagram
//
//  Created by swiftdev on 2016/03/22.
//  Copyright © 2016年 kiyoko.ohashi. All rights reserved.
//

import UIKit

class ImageSelectViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AdobeUXImageEditorViewControllerDelegate {

    //ライブラリボタンを押した時に呼ばれるメソッド
    @IBAction func handleLibraryButton(sender: AnyObject) {
        
        //ライブラリ（カメラロール）を指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(pickerController, animated: true, completion: nil)
        }
    }
    
    //カメラボタンを押した時に呼ばれるメソッド
    @IBAction func handleCameraButton(sender: AnyObject) {
        
        //カメラを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
        let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(pickerController, animated: true, completion: nil)
        }
        
    }
    //キャンセルボタンを押した時に呼ばれるメソッド
    @IBAction func handleCancelButton(sender: AnyObject) {
        //画面を閉じる
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //写真を撮影/選択した時に呼ばれるメソッド
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
        if info[UIImagePickerControllerOriginalImage] != nil {
        //撮影/選択された画像を取得する
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            //ここでpresentViewControllerを呼び出しても表示されないためメソッドが終了してから呼ばれるようにする
            dispatch_async(dispatch_get_main_queue()) {
            
                //AdobeImageEditorを起動する
                let adobeViewController = AdobeUXImageEditorViewController(image: image)
                adobeViewController.delegate = self
                self.presentViewController(adobeViewController, animated: true, completion: nil)
            }
        }
        
        //閉じる
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //閉じる
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //AdobeImageEditorで加工が終わった時に呼ばれる
    func photoEditor(editor: AdobeUXImageEditorViewController, finishedWithImage image: UIImage?){
    //画面加工画面を閉じる
        editor.dismissViewControllerAnimated(true, completion: nil)
        
        //投稿の画面を開く
        let postViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Post") as! PostViewController
        postViewController.image = image
        presentViewController(postViewController, animated: true, completion: nil)
    }
    
    //AdobeImageEditorで加工をキャンセルした時に呼ばれる
    func photoEditorCanceled(editor: AdobeUXImageEditorViewController){
    //エディタ画面を閉じる
        editor.dismissViewControllerAnimated(true, completion: nil)
    }
}
