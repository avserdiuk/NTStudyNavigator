//
//  PasswordViewController.swift
//  Navigator
//
//  Created by Алексей Сердюк on 14.10.2024.
//

import UIKit
import KeychainAccess

class PasswordViewController: UIViewController {
    
    let keychain = Keychain(service: "com.navigator-token")
    var password: String?
    var state = 0
    
    private lazy var textField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if keychain["password"] == nil {
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            button.setTitle("Создать пароль", for: .normal)
        } else {
            button.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
            button.setTitle("Проверить пароль", for: .normal)
        }
        
        
        
        view.addSubview(textField)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 250),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.heightAnchor.constraint(equalToConstant: 44)
            
        ])
        
    }
    
    @objc
    func didTapBtn(){
        guard let password = textField.text, textField.text != "" else { return }
        guard password.count >= 4 else { return }
        
        let key = keychain["password"]
        if textField.text == key {
            print("Пароли совпадают")
            
            UserDefaults.standard.setValue(123, forKey: "123")
        } else {
            self.textField.text = nil
            let alert = UIAlertController(title: "Ошибка!", message: "Пароли не совпадают", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Повторить", style: .cancel))
            present(alert, animated: true)
        }
    }
    
    @objc
    func didTapButton(){
        guard let password = textField.text, textField.text != "" else { return }
        guard password.count >= 4 else { return }
        
        if state == 0 {
            self.password = password
            self.state = 1
            self.button.setTitle("Повторите пароль", for: .normal)
            self.textField.text = nil
        } else {
            if password == self.password {
                print("Пароли совпадают")
                keychain["password"] = password
                
            } else {
                self.state = 0
                self.password = nil
                self.button.setTitle("Создать пароль", for: .normal)
                self.textField.text = nil
                let alert = UIAlertController(title: "Ошибка!", message: "Пароли не совпадают", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Повторить", style: .cancel))
                present(alert, animated: true)
            }
        }
        
        
        
        
    }
}
