//
//  PostViewController.swift
//  Navigator
//
//  Created by Алексей Сердюк on 18.09.2024.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = post?.title
        view.backgroundColor = .systemGray4
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showInfo))
        navigationItem.rightBarButtonItems = [add]
    }
    
    @objc func showInfo() {
        present(InfoViewController(), animated: true)
    }
    
}

