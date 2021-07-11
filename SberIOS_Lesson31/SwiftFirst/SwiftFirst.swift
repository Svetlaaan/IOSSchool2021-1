//
//  SwiftFirst.swift
//  SwiftFirst
//
//  Created by Svetlana Fomina on 11.07.2021.
//

import Foundation
import SwiftSecond
import ObjCModule

@objc open class SwiftFirst: NSObject {

	@objc public func testOne() {
		print("First swift static library")
	}

	@objc public func testAnotherSwiftLibrary() {
		let swiftSecond = SwiftSecond()
		swiftSecond.testTwo()
	}

	public func testAnotherObjCLibrary() {
		let objc = ObjCFirst()
		objc.testThree()
	}

}
