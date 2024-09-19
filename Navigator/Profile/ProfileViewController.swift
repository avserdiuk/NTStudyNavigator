//
//  Untitled.swift
//  Navigator
//
//  Created by Алексей Сердюк on 18.09.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var headerView : ProfileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemGroupedBackground
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(headerView)
        headerView.frame = view.frame
    }
}
