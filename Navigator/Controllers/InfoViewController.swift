//
//  InfoViewController.swift
//  Navigator
//
//  Created by Алексей Сердюк on 18.09.2024.
//
import UIKit

class InfoViewController: UIViewController{
    
    private lazy var button: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        button.setTitle("Alert", for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        button.center = view.center
        
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "Alert", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        let action1 = UIAlertAction(title: "CLOSE", style: .destructive)
        alert.addAction(action1)
        present(alert, animated: true)
    }
}
