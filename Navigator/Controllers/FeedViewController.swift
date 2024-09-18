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
        button.setTitle("Show Post", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
    }
    
    @objc func didTapButton() {
        var post = Post(title: "New Post")
        var controller = PostViewController()
        controller.post = post
        navigationController?.pushViewController(controller, animated: true)
    }
}

