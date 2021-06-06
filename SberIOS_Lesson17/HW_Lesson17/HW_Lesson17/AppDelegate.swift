//
//  AppDelegate.swift
//  HW_Lesson17
//
//  Created by Svetlana Fomina on 06.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		let service = NASANetworkService()

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = UINavigationController(rootViewController: ViewController(networkService: service))
		window?.makeKeyAndVisible()
		return true
	}

}
