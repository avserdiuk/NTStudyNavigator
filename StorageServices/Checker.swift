//
//  Checker.swift
//  Navigator
//
//  Created by Алексей Сердюк on 01.10.2024.
//

class Checker {
    public static let shared = Checker()
    private init() {}
    
    private let login: String = "Alf"
    private let password : String = ""
    

    public func check(login: String, password: String) -> Bool {
        if login == self.login && password == self.password {
            return true
        } else {
            return false
        }
    }
}

public protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}

public struct LoginInspector : LoginViewControllerDelegate {
    public init(){}
    
    public func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }
}

/*---------------------------------------------*/

public protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

public struct MyLoginFactory : LoginFactory {
    public init(){}
    
    public func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
