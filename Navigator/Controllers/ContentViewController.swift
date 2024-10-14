//
//  ContentViewController.swift
//  Navigator
//
//  Created by Алексей Сердюк on 14.10.2024.
//

import UIKit
import Foundation

class ContentViewController: UIViewController, UINavigationControllerDelegate{
    
    let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var contentAtDocuments: [URL] {
        do {
            let contentAtDocuments = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: [], options: .skipsHiddenFiles)
            return contentAtDocuments
        } catch {
            print(error.localizedDescription)
            return []
        }
        
    }
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFoto))
        navigationItem.rightBarButtonItems = [add]
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    @objc
    func addFoto(){
        let controller = UIImagePickerController()
        controller.delegate = self
        present(controller, animated: true)
    }
    
}

extension ContentViewController: UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contentAtDocuments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = contentAtDocuments[indexPath.row].lastPathComponent
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            let cell = tableView.cellForRow(at: indexPath)
            if let name = cell?.textLabel?.text {
                    
                let path = documentsUrl.appending(path: name)
                do {
                    try FileManager.default.removeItem(at: path)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                } catch {
                    print(error)
                }
            }
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[.imageURL] {
            do {
                let name = url as! URL
                try FileManager.default.copyItem(at: name, to: documentsUrl.appending(path: name.lastPathComponent))
                dismiss(animated: true)
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
    }
    
}
