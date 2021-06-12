//
//  ViewController.swift
//  MyFramework
//
//  Created by Svetlana Fomina on 11.06.2021.
//

import UIKit

open class MyViewController: UIViewController {

	open func changeBackground(withColor color: UIColor) {
		self.view.backgroundColor = color
	}

	open lazy var label: UILabel = {
		let label = UILabel()
		label.text = "It works with my Carthage!\n Tap to change color"
		label.textAlignment = .center
		label.numberOfLines = 2
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize:20)
		return label
	}()

	open override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(label)
		setAutoLayout()
	}

	func setAutoLayout() {
		label.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}

}
