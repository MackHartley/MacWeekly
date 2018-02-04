//
//  api.swift
//  The Mac Weekly
//
//  Created by Library Checkout User on 2/3/18.
//  Copyright © 2018 The Mac Weekly. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


public struct Author {
    var id: Int
    var name: String
    
    init?(json:JSON) {
        if let idString = json["id"].string, let name = json["name"].string {
            guard let id = Int(idString) else {
                return nil
            }
            self.id = id
            self.name = name
        } else {
            return nil
        }
    }
}

public struct Post {
    var author: Author?
    var title: String
    var body: String
    var time: Date
    
    init?(json:JSON) {
        if let title = json["title"]["rendered"].string, let body = json["content"]["rendered"].string, let timeString = json["date"].string {
            self.title = title
            self.body = body
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            guard let time = formatter.date(from: timeString) else {
                return nil
            }
            self.time = time
            self.author = Author(json: json["guest_author"])
            
        } else {
            return nil
        }
    }
}
let API_ROOT = URL(string: "http://themacweekly.com/wp-json/wp/v2/")!

public func getPosts(_ page: Int = 1, completion: @escaping ([Post?]) -> Void) -> DataRequest {
    var url = URLComponents(string: "posts")
    url?.queryItems = [URLQueryItem(name: "page", value: String(page))]
    return Alamofire.request(url!.url(relativeTo: API_ROOT)!).responseJSON { response in
        if let json = response.result.value {
            completion(JSON(json).array?.map { postJSON in
                return Post(json: postJSON)
            } ?? [])
            
        } else {
            completion([])
        }
    }
}

public func getPost(postID: Int,  completion: @escaping (Post?) -> Void ) -> DataRequest {
    return Alamofire.request(API_ROOT.appendingPathComponent("posts/\(postID)")).responseJSON { response in
        if let json = response.result.value {
            completion(Post.init(json: JSON.init(json)))
        } else {
            completion(nil)
        }
    }
}

