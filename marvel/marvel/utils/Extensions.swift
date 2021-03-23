//
//  ControllersUtils.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 20/03/21.
//

import Foundation
import UIKit
import CoreData

extension UIView {
    public func loaderElement(indicator: UIActivityIndicatorView, show start: Bool){
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = self.center
        self.addSubview(indicator)
        
        if(start){
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
            indicator.hidesWhenStopped = true
        }
    }
}

extension UIViewController {
    var coreDataContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}