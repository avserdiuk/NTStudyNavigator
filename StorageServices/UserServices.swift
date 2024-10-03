//
//  User.swift
//  Navigator
//
//  Created by Алексей Сердюк on 30.09.2024.
//

import UIKit

public protocol UserService {
    var user: User { get set}
    func auth(login: String) -> User?
}

extension UserService {
    public func auth(login: String) -> User? {
        login == user.login ? user : nil
    }
}

public class User {
    public let login: String
    public let password: String
    public let avatar: UIImage
    public let status: String
    
    public init(login: String, password: String, avatar: UIImage, status: String) {
        self.login = login
        self.password = password
        self.avatar = avatar
        self.status = status
    }
}

public class CurrentUserService : UserService {
    public var user: User
    
    public init(user: User) {
        self.user = user
    }
}

public class TestUserService : UserService {
    public var user: User = User(login: "test", password: "123", avatar: UIImage(named: "alf")!, status: "test «test» test")
    public init(){}
}
