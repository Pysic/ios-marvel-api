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
    
    func alertModal(title: String, message: String, onOk: @escaping () -> Void, onCancel: @escaping () -> Void){
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                onOk()
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                onCancel()
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
}

extension UIButton {
    func renderFavoriteButton (hero: HeroModel) {
        let favoriteImage = hero.favorite ? "star.fill" : "star"
        let image = UIImage(systemName: favoriteImage) as UIImage?
        self.setBackgroundImage(image, for: .normal)
    }
}
