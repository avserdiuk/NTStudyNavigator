//
//  Checker.swift
//  Navigator
//
//  Created by Алексей Сердюк on 01.10.2024.
//

import FirebaseCore
import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String, completion: @escaping (Result<String, Error>, String?) -> Void) // login
    func signUp() //signup
}

class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String, completion: @escaping (Result<String, Error>, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                switch error.localizedDescription {
                case "There is no user record corresponding to this identifier. The user may have been deleted.":
                    Auth.auth().createUser(withEmail: email, password: password){ result , error in
                        if let error {
                            completion(.failure(error), error.localizedDescription)
                        }
                        if let result {
                            completion(.success("User signed in \(result.user.email ?? "")"), "new user created")
                        }
                    }
                case "The email address is badly formatted.":
                    completion(.failure(error), error.localizedDescription)
                default:
                    print("Unknown error")
                }
            }
            
            if let result {
                completion(.success("User signed in \(result.user.email ?? "")"), nil)
                
            }
        }
    }
        
    func signUp() {
    }
}


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
