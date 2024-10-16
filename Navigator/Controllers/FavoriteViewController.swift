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
        
        title = "Избранное"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItems?.append(UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search)))
        
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
        CoreDateServices.shared.getPosts()
        tableView.reloadData()
    }
    
    @objc
    func search(){
        let alert = UIAlertController(title: "Поиск", message: "Введите автора", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?.first?.placeholder = "Автор"
        alert.addAction(UIAlertAction(title: "Поиск", style: .default, handler: { UIAlertAction in
            
            CoreDateServices.shared.search(text: alert.textFields?.first?.text ?? "")
            self.tableView.reloadData()
        }))
        present(alert, animated: true)
    }
    
    @objc
    func refresh(){
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Удалить") {_,_,_ in
            CoreDateServices.shared.deletePostFromFavorites(posts[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}
