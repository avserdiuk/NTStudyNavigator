//
//  Untitled.swift
//  Navigator
//
//  Created by Алексей Сердюк on 18.09.2024.
//

import UIKit
import StorageServices

class FeedViewController: UIViewController {
    
    var viewModel: FeedModel?
    
    private lazy var customBtn = CustomButton(title: " Show Post ", action: didTapButton)
    private lazy var customBtn1 = CustomButton(title: " Show Post1 ", action: didTapButton)
    
    private lazy var textField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your text"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var checkGuessButton = CustomButton(title: "checkGuessButton", action: didTapCheckGuessButton)
    
    private lazy var resultLabel : UILabel = {
       let label = UILabel()
        label.text = "Result: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(customBtn)
        stackView.addArrangedSubview(customBtn1)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(checkGuessButton)
        stackView.addArrangedSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func didTapButton() {
        let post = PostTitle(title: "New Post")
        let controller = PostViewController()
        controller.post = post
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func didTapCheckGuessButton() {
        guard let password = textField.text  else { return }
        
        guard let feedModel = viewModel else { return }
        
        let result = feedModel.check(password: password)
        
        if result {
            resultLabel.backgroundColor = .green
        } else {
            resultLabel.backgroundColor = .red
        }
    }
}

