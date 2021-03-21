//
//  ControllersUtils.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 20/03/21.
//

import Foundation
import UIKit

class ControllersUtils {
    public func loaderElement(indicator: UIActivityIndicatorView, view: UIView, show start: Bool){
        
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = view.center
        view.addSubview(indicator)
        
        if(start){
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
            indicator.hidesWhenStopped = true
        }
        
    }
}
