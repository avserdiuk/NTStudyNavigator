//
//  CustomButton.swift
//  Navigator
//
//  Created by Алексей Сердюк on 02.10.2024.
//

import UIKit

class CustomButton : UIButton {
    
    var action: ()->()
    
    init(title: String, action: @escaping ()->()) {
        
        self.action = action
        
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBlue
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
       }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        self.action()
    }
}
