//
//  ViewController.swift
//  MyFirstDrawer
//
//  Created by NEVERCUTE on 11/03/2019.
//  Copyright © 2019 NEVERCUTE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let canvas = Canvas()
    
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleUndo(){
        canvas.undo()
    }
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleClear(){
        canvas.clear()
    }
    
    override func loadView() {
        self.view = canvas
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvas.backgroundColor = .white
        
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        let stackView = UIStackView(arrangedSubviews: [
            undoButton,
            clearButton
            ])
        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}


