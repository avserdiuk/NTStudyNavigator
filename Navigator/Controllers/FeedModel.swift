//
//  FeedModel.swift
//  Navigator
//
//  Created by Алексей Сердюк on 02.10.2024.
//

class FeedModel {
    var password = "123"
    
    func check(password: String) -> Bool {
        self.password == password ? true : false
    }
}
