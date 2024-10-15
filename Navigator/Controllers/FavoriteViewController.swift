//
//  FavoriteViewController.swift
//  Navigator
//
//  Created by Алексей Сердюк on 15.10.2024.
//

import UIKit
import StorageServices

class FavoriteViewController: UIViewController {
    
    private lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        CoreDateServices.shared.getPosts()
        tableView.reloadData()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CoreDateServices.shared.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostTableViewCell()
        let post = Post(
            author: CoreDateServices.shared.posts[indexPath.row].author!,
            description: CoreDateServices.shared.posts[indexPath.row].desc!,
            image: CoreDateServices.shared.posts[indexPath.row].image!,
            likes: Int(CoreDateServices.shared.posts[indexPath.row].likes),
            views: Int(CoreDateServices.shared.posts[indexPath.row].views)        )
        cell.setup(post: post)
        cell.selectionStyle = .none
        return cell
    }
    
    
}
