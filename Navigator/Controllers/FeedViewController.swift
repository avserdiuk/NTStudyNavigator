//
//  Untitled.swift
//  Navigator
//
//  Created by Алексей Сердюк on 18.09.2024.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var button : UIButton = {
        let button = UIButton(frame: CGRect(x: view.center.x-50, y: view.center.y-22, width: 100, height: 44))
        button.setTitle(" Show Post ", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private lazy var button1 : UIButton = {
        let button = UIButton(frame: CGRect(x: view.center.x-50, y: view.center.y-22, width: 100, height: 44))
        button.setTitle(" Show Post1 ", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        return button
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
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(button1)
        
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

