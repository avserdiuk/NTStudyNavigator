//
//  FavoriteViewController.swift
//  Navigator
//
//  Created by Алексей Сердюк on 15.10.2024.
//

import UIKit
import StorageServices
import CoreData

class FavoriteViewController: UIViewController {
    
    private lazy var fetchController: NSFetchedResultsController = {
        
        let fetchRequest = CDPost.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        let context = CoreDateServices.shared.persistentContainer.viewContext
        
        let f = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        f.delegate = self
        return f
    }()
    
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
        fetchPerform()
    }
    
    func fetchPerform(){
        do {
            try fetchController.performFetch()
            tableView.reloadData()
        } catch {
            fatalError("Failed to perform fetch: \(error.localizedDescription)")
        }
    }
    
    @objc
    func search(){
        let alert = UIAlertController(title: "Поиск", message: "Введите автора", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?.first?.placeholder = "Автор"
        alert.addAction(UIAlertAction(title: "Поиск", style: .default, handler: { UIAlertAction in

            self.fetchController.fetchRequest.predicate = NSPredicate(format: "author = %@", alert.textFields?.first?.text ?? "")
            self.fetchPerform()

        }))
        present(alert, animated: true)
    }
    
    @objc
    func refresh(){
        self.fetchController.fetchRequest.predicate = nil
        self.fetchPerform()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchController.sections?[0].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostTableViewCell()
        let post = Post(
            author: fetchController.fetchedObjects?[indexPath.row].author ?? "",
            description: fetchController.fetchedObjects?[indexPath.row].desc ?? "",
            image: fetchController.fetchedObjects?[indexPath.row].image ?? "",
            likes: Int(fetchController.fetchedObjects?[indexPath.row].likes ?? 0),
            views: Int(fetchController.fetchedObjects?[indexPath.row].views ?? 0)
        )
        cell.setup(post: post)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Удалить") {_,_,_ in
            CoreDateServices.shared.deletePostFromFavorites(posts[indexPath.row])
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?){
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        default:
            return
        }
    }
    
}
