//
//  PhotosTableViewCell.swift
//  Navigator
//
//  Created by Алексей Сердюк on 24.09.2024.
//

import UIKit

class PhotosTableViewCell : UITableViewCell {
    
    private lazy var labelTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var imageViewArrow : UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "arrow.right"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .black
        return image
    }()
    
    private lazy var layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.minimumInteritemSpacing = 8
        return layout
    }()
    
    private lazy var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Default")
        collection.showsHorizontalScrollIndicator = false

        return collection
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(labelTitle)
        contentView.addSubview(imageViewArrow)
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            labelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            imageViewArrow.centerYAnchor.constraint(equalTo: labelTitle.centerYAnchor),
            imageViewArrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            imageViewArrow.widthAnchor.constraint(equalToConstant: 25),
            imageViewArrow.heightAnchor.constraint(equalToConstant: 25),
            
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 12),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            collectionView.heightAnchor.constraint(equalToConstant: contentView.frame.width / 4)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Default", for: indexPath) 
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 6
        cell.backgroundView = UIImageView(image: UIImage(named: "alf"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let width = window?.frame.width {
            let size = Double((width - 54) / 4)
            return CGSize(width: size, height: size)
        } else {
            return CGSize(width: 10, height: 10)
        }
        
    }
    
    
}
