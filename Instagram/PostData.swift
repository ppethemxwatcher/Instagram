//
//  PostData.swift
//  Instagram
//
//  Created by swiftdev on 2016/03/24.
//  Copyright © 2016年 kiyoko.ohashi. All rights reserved.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: NSDate?
    var likes: [String] = []
    var isLiked: Bool = false
    var followername: [String] = []
    var comment: [String] = []
    
    init(snapshot: FDataSnapshot, myId: String) {
        id = snapshot.key
        
        imageString = snapshot.value.objectForKey("image") as? String
        image = UIImage(data: NSData(base64EncodedString: imageString!, options: .IgnoreUnknownCharacters)!)
        
        name = snapshot.value.objectForKey("name") as? String
        caption = snapshot.value.objectForKey("caption") as? String
        
        if let likes = snapshot.value.objectForKey("likes") as? [String] {
        self.likes = likes
        }
        
        if let followername = snapshot.value.objectForKey("followername") as? [String] {
        self.followername = followername
        }
        
        if let comment = snapshot.value.objectForKey("comment") as? [String] {
        self.comment = comment
        }
        
        for likeId in likes {
            if likeId == myId {
            isLiked = true
                break
            }
        }
        
        self.date = NSDate(timeIntervalSinceReferenceDate: snapshot.value.objectForKey("time") as! NSTimeInterval)
    }
}
