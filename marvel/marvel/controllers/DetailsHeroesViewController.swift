//
//  DetailsHeroesViewController.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 20/03/21.
//

import UIKit

class DetailsHeroesViewController: UIViewController {

    @IBOutlet weak var nameDescriptionDetail: UITextView!
    @IBOutlet weak var nameHeroDetail: UILabel!
    @IBOutlet weak var imageHeroDetail: UIImageView!
    var hero: HeroModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameDescriptionDetail.isEditable = false
        
        nameHeroDetail.text = hero.name
        nameDescriptionDetail.text = hero.description == "" ? "This hero don't have a description" : hero.description
        imageHeroDetail.image = ControllersUtils().processImage(hero: hero)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
