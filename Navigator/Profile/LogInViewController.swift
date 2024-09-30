//
//  LogInViewController.swift
//  Navigator
//
//  Created by Алексей Сердюк on 20.09.2024.
//

import UIKit
import StorageServices

class LogInViewController: UIViewController {
    
    private lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var imageViewLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        return stackView
    }()
    
    private lazy var textFieldLogin: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or Phone"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.systemGray6
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()
    
    private lazy var hl : UIView = {
        let hl = UIView()
        hl.backgroundColor = UIColor.lightGray
        hl.translatesAutoresizingMaskIntoConstraints = false
        return hl
    }()
    
    
    private lazy var textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.systemGray6
        textField.isSecureTextEntry = true
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.keyboardType = .default
        return textField
    }()
    
    private lazy var buttonLogin: UIButton = {
        let btn = UIButton()
        btn.setTitle("Log In", for: .normal)
        btn.tintColor = .white
        btn.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(goTo), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageViewLogo)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(textFieldLogin)
        stackView.addArrangedSubview(hl)
        stackView.addArrangedSubview(textFieldPassword)
        
        scrollView.addSubview(buttonLogin)
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            imageViewLogo.heightAnchor.constraint(equalToConstant: 100),
            imageViewLogo.widthAnchor.constraint(equalToConstant: 100),
            imageViewLogo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageViewLogo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.topAnchor.constraint(equalTo: imageViewLogo.bottomAnchor, constant: 120),
            
            textFieldLogin.heightAnchor.constraint(equalToConstant: 49.75),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 49.75),
            hl.heightAnchor.constraint(equalToConstant: 0.5),
            hl.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            buttonLogin.heightAnchor.constraint(equalToConstant: 50),
            buttonLogin.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            buttonLogin.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            buttonLogin.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16)
            
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
        keyboardHide()
    }
    
    @objc private func goTo(){
        let login = textFieldLogin.text ?? ""
        
        var service : UserService = CurrentUserService(user: User(login: "Alf", password: "123", avatar: UIImage(named: "alf")!, status: "Gordon «Alf» Shumway"))
        
        #if DEBUG
            service = TestUserService()
        #endif
        
        if let user = service.auth(login: login)  {
            let vc = ProfileViewController()
                vc.user = user
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Ошибка!", message: "Не верный логин", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Повторить", style: .cancel))
            present(alert, animated: true)
        }
        
    }
    
    @objc func keyboardShow(_ notification: Notification){
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            let keyboardMinY = view.frame.height - keyboardRectangle.height
            let btnMaxY = buttonLogin.frame.maxY
            
            if btnMaxY > keyboardMinY {
                let needToUp = btnMaxY - keyboardMinY + 32
                scrollView.contentOffset = CGPoint(x: 0, y: needToUp)
                
            }
        }
    }
    
    @objc func keyboardHide(){
        print(#function)
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
}
