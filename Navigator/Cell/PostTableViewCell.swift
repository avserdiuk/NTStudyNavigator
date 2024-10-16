//
//  PostTableViewCell.swift
//  Navigator
//
//  Created by Алексей Сердюк on 23.09.2024.
//

import UIKit
import StorageServices

class PostTableViewCell: UITableViewCell {
    
    var post: Post?
    var tapRecognizer: Bool = false
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var image : UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var labelLikes: UILabel = {
        let label = UILabel()
        label.text = "Likes: 1"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var labelViews: UILabel = {
        let label = UILabel()
        label.text = "Views: 1"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(labelTitle)
        addSubview(image)
        addSubview(labelDescription)
        addSubview(labelLikes)
        addSubview(labelViews)
        
        
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: super.topAnchor, constant: 16),
            labelTitle.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 16),
            
            image.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 12),
            image.leadingAnchor.constraint(equalTo: super.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: super.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: super.frame.width),
            
            labelDescription.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            labelDescription.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 16),
            labelDescription.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -16),
            
            labelLikes.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 16),
            labelLikes.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 16),
            
            labelViews.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 16),
            labelViews.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: -16),
            labelViews.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: -16)
            
            
        ])
        
        
        
    }
    
    @objc
    func didTapPost(){
        if let post {
            CoreDateServices.shared.addPostToFavorites(post)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(post: Post){
        self.post = post
        labelTitle.text = post.author
        image.image = UIImage(named: post.image)
        labelDescription.text = post.description
        labelLikes.text = "Likes: \(post.likes)"
        labelViews.text = "Views: \(post.views)"
        
        if tapRecognizer {
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPost))
            tapRecognizer.numberOfTapsRequired = 2
            self.addGestureRecognizer(tapRecognizer)
        }
    }
}
