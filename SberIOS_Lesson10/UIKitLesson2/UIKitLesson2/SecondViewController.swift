//
//  SecondViewController.swift
//  UIKitLesson2
//
//  Created by Deniz Kaplan on 14.05.2021.
//

import UIKit

final class SecondViewController: UIViewController {
    
    lazy var infoBlock: InfoBlockView = {
        let view = InfoBlockView(text: "Hello! 👋")
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        view.addSubview(infoBlock)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        infoBlock.frame = .init(x: 0, y: 0, width: 200, height: 200)
        infoBlock.center = view.center
    }
    
}
