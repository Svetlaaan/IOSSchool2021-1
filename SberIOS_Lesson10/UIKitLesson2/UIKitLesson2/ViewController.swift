//
//  ViewController.swift
//  UIKitLesson2
//
//  Created by Deniz Kaplan on 14.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var button: ButtonView = {
        let button = ButtonView(diameter: view.frame.height / 8)
        
        button.setTitle("ViewController2", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var donut: DonutView = {
        let donut = DonutView(diameter: view.frame.height / 4)
        donut.backgroundColor = .red
        return donut
    }()
    
    lazy var donutHole: DonutView = {
        let donutHole = DonutView(diameter: view.frame.height / 8)
        donutHole.backgroundColor = self.view.backgroundColor
        return donutHole
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        button.addSubview(donut)
        view.addSubview(button)
        donut.addSubview(donutHole)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = (view.frame.height / 8) / 2
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: view.frame.height / 8),
            button.heightAnchor.constraint(equalToConstant: view.frame.height / 8)
        ])
        
        donut.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            donut.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            donut.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            donut.widthAnchor.constraint(equalToConstant: view.frame.height / 4),
            donut.heightAnchor.constraint(equalToConstant: view.frame.height / 4)
        ])
        
        donutHole.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            donutHole.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            donutHole.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            donutHole.widthAnchor.constraint(equalToConstant: view.frame.height / 8),
            donutHole.heightAnchor.constraint(equalToConstant: view.frame.height / 8)
        ])
        
    }
    
    @objc func buttonTapped() {
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
}
