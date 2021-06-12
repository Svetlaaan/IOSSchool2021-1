//
//  ViewController.swift
//  MyFramework
//
//  Created by Svetlana Fomina on 11.06.2021.
//

import UIKit

public class MyViewController: UIViewController {

	public func changeBackground(withColor color: UIColor) {
		self.view.backgroundColor = color
	}

	public var label: UILabel = {
		let label = UILabel()
		label.text = "It works with my Carthage!\n Tap to change color"
		label.textAlignment = .center
		label.numberOfLines = 2
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize:20)
		return label
	}()

}
