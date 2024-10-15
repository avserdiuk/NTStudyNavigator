//
//  Untitled.swift
//  Navigator
//
//  Created by Алексей Сердюк on 18.09.2024.
//

import UIKit
import StorageServices

class ProfileViewController: UIViewController {
    
    var user: User?
    private lazy var startPosition: CGPoint = imageView.center
    
    private lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        return table
    }()
    
    private lazy var wrapper : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "alf")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 50
        imageView.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        imageView.layer.borderWidth = 3
        
        imageView.alpha = 0
        return imageView
    }()
    
    private lazy var imageViewClose: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "xmark")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.tintColor = .white
        imageView.alpha = 0
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        title = "Profile"
        view.backgroundColor = .systemGroupedBackground
        
        view.addSubview(tableView)
        view.addSubview(wrapper)
        view.addSubview(imageView)
        view.addSubview(imageViewClose)
        
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            wrapper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wrapper.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            
            imageViewClose.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageViewClose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageViewClose.heightAnchor.constraint(equalToConstant: 20),
            imageViewClose.widthAnchor.constraint(equalToConstant: 20),
        ])
        
        let tapClose = UITapGestureRecognizer(target: self, action: #selector(imageCloseTapped))
        imageViewClose.addGestureRecognizer(tapClose)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func showAnimation(){
        print(imageView.center)
        print(startPosition)
        
        self.imageView.alpha = 1
        
        UIView.animate(withDuration: 1) {
            
            self.wrapper.alpha = 0.7
            self.imageView.center = self.view.center
            self.imageView.transform = CGAffineTransform(scaleX: self.view.frame.width / self.imageView.frame.width, y: self.view.frame.width / self.imageView.frame.width)
            self.imageView.layer.cornerRadius = 0
        } completion: { _ in
            self.imageView.isUserInteractionEnabled = false
                UIView.animate(withDuration: 0.3) {
                    self.imageViewClose.alpha = 1
                }
        }
        
    }
    
    @objc func imageCloseTapped(){
        print(imageView.center)
        print(startPosition)
        
        UIView.animate(withDuration: 1) {
            self.wrapper.alpha = 0
            self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.imageView.center = self.startPosition
            self.imageViewClose.alpha = 0
            self.imageView.layer.cornerRadius = 50
        } completion: { _ in
            self.imageView.alpha = 0
        }
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return posts.count
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = PostTableViewCell()
            cell.tapRecognizer = true
            cell.setup(post: posts[indexPath.row])
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = PhotosTableViewCell()
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = ProfileHeaderView()
            view.setup(user: user!)
            view.delegate = self
            return view
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        }
    }
    
}
