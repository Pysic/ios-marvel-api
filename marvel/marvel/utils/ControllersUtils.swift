//
//  ControllersUtils.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 20/03/21.
//

import Foundation
import UIKit

class ControllersUtils {
    public func processImage(hero: HeroModel) -> UIImage?{
        var image: UIImage?
        do {
            if let url = URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.extension)"){
                let data = try Data(contentsOf: url)
                image = UIImage(data: data)
            } else {
                print("URL de imagem inválida.")
            }
        } catch {
            print(error)
        }
        return image
    }
    
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
