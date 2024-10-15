//
//  PhotosCollectionViewCell.swift
//  Navigator
//
//  Created by Алексей Сердюк on 24.09.2024.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "alf"))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: super.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: super.trailingAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: super.topAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: super.bottomAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage){
        imageView.image = image
    }
}
