//
//  ProfileHeaderView.swift
//  Navigator
//
//  Created by Алексей Сердюк on 19.09.2024.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    private var statusText : String?
    var delegate: ProfileViewController?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "alf")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        imageView.layer.borderWidth = 3
        
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.text = "Gordon «Alf» Shumway"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelWaiting: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 4
        button.layer.shadowColor = CGColor(gray: 0, alpha: 1)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your status"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = CGColor(gray: 0, alpha: 1)
        textField.layer.borderWidth = 1
        
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return textField
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        addSubview(imageView)
        addSubview(labelName)
        addSubview(button)
        addSubview(labelWaiting)
        addSubview(textField)
        
        backgroundColor = .systemBackground
        
//        NSLayoutConstraint.activate([
//            
//            imageView.topAnchor.constraint(equalTo: super.safeAreaLayoutGuide.topAnchor, constant: 16),
//            imageView.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 16),
//            imageView.heightAnchor.constraint(equalToConstant: 100),
//            imageView.widthAnchor.constraint(equalToConstant: 100),
//            
//            labelName.topAnchor.constraint(equalTo: super.safeAreaLayoutGuide.topAnchor, constant: 27),
//            labelName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 27),
//            
//            button.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 16),
//            button.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -16),
//            button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
//            button.heightAnchor.constraint(equalToConstant: 50),
//            button.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -16),
//            
//            labelWaiting.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
//            labelWaiting.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -60),
//            
//            textField.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
//            textField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10),
//            textField.heightAnchor.constraint(equalToConstant: 40),
//            textField.trailingAnchor.constraint(equalTo: button.trailingAnchor),
//            
//        ])
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        labelName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.left.equalTo(imageView.snp.right).offset(27)
        }
        
        button.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        labelWaiting.snp.makeConstraints { make in
            make.leading.equalTo(labelName.snp.leading)
            make.top.equalTo(labelName.snp.bottom).offset(7)
        }
        
        textField.snp.makeConstraints { make in
            make.leading.equalTo(labelName.snp.leading)
            make.bottom.equalTo(button.snp.top).offset(-10)
            make.height.equalTo(40)
            make.trailing.equalTo(button.snp.trailing)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func imageTapped(){
        if let delegate {
            delegate.showAnimation()
        }
    }
    
    @objc func buttonPressed(){
        labelWaiting.text = statusText
        textField.text = nil
    }
    
    @objc func statusTextChanged(_ textField: UITextField){
        statusText = textField.text
    }
}

