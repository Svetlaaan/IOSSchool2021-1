//
//  ViewController.swift
//  SberIOS_Lesson31
//
//  Created by Svetlana Fomina on 11.07.2021.
//

import UIKit
import SwiftFirst
import ObjCModule

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		// Статическая библиотека Swift используется в другой статической библиотеке Swift
		let testSwift = SwiftFirst()
		testSwift.testAnotherSwiftLibrary()

		// Статическая библиотека Objective-C используется в статической библиотеке Swift
		let testObjcInSwift = SwiftFirst()
		testObjcInSwift.testAnotherObjCLibrary()

		// Статическая библиотека Objective-C используется в другой статической библиотеке Objective-C
		let testObjC = ObjCFirst()
		testObjC.testAnotherObjCLibrary()
	}


}

