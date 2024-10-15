//
//  PhotosViewController.swift
//  Navigator
//
//  Created by Алексей Сердюк on 24.09.2024.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    let imageProcessor = ImageProcessor()
    var images = [UIImage] (repeating: UIImage(named: "alf")!, count: 10)
    var timer: Timer?
    
    private lazy var layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
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
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "Custom")
        collection.showsHorizontalScrollIndicator = false

        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        title = "Photo Gallery"
       
        
        self.startFilter()
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

        ])
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
        print("timer has invalidate")
        
    }
    
    func startFilter(){
        
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            
            let time1 = NSDate().timeIntervalSince1970
            
            self.imageProcessor.processImagesOnThread(sourceImages: self.images, filter: .allCases.randomElement()!, qos: .userInteractive) { newImages in
                DispatchQueue.main.async {
                    
                    self.images = []
                    
                    newImages.forEach { imga in
                        let img = UIImage(cgImage: imga!)
                        self.images.append(img)
                    }
                    
                    self.collectionView.reloadData()
                    
                    let time2 = NSDate().timeIntervalSince1970
                    print("done at ", time2-time1)
                    
                    
                }
            }
            
            print("timer has worked")
        }
    }
    
    
    
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom", for: indexPath) as! PhotosCollectionViewCell
        cell.setup(image: images[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = view.frame.width
        let size = (screenWidth - 54) / 3
        return CGSize(width: size, height: size)
    }
    
}
