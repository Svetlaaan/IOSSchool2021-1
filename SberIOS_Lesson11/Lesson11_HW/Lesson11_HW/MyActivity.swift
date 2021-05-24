//
//  MyActivity.swift
//  Lesson11_HW
//
//  Created by Svetlana Fomina on 23.05.2021.
//

import UIKit

class MyActivity: UIActivity {
    
    override class var activityCategory: UIActivity.Category {
        return .share
    }
    
    override var activityType: UIActivity.ActivityType? {
        return UIActivity.ActivityType(rawValue: "activity.postToDoggogramm")
    }
    
    override var activityTitle: String? {
        return "Doggogramm"
    }
    
    override var activityImage: UIImage? {
        return UIImage(named: "doggoLogo")!
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    // При выборе активити отображается модальное окно, с одной экшн кнопкой
    override var activityViewController: UIViewController? {
        let alertController = UIAlertController(title: "Success", message: "You posted photo to Doggogramm", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "woof", style: .default) { (action) in
            self.activityDidFinish(true)
        }
        alertController.addAction(action)
        return alertController
    }
    
}
