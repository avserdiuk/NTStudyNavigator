//
//  Untitled.swift
//  Navigator
//
//  Created by Алексей Сердюк on 18.09.2024.
//

import UIKit
import StorageServices

class FeedViewController: UIViewController {
    
    private lazy var customBtn = CustomButton(title: " Show Post ", action: didTapButton)
    private lazy var customBtn1 = CustomButton(title: " Show Post1 ", action: didTapButton)
    
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
}

