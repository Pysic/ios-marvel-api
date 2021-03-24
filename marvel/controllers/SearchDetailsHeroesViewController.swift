//
//  DetailsHeroesViewController.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 20/03/21.
//

import UIKit
import Kingfisher

class SearchDetailsHeroesViewController: UIViewController {

    @IBOutlet weak var nameDescriptionDetail: UITextView!
    @IBOutlet weak var nameHeroDetail: UILabel!
    @IBOutlet weak var imageHeroDetail: UIImageView!
    @IBOutlet weak var buttonFavoriteDetail: UIButton!
    
    @IBAction func buttonFavoriteDetailClick(_ sender: UIButton) {
        hero.favorite ? CoreDataHandler.shared.deleteByHero(hero: hero) : CoreDataHandler.shared.insertHero(hero: hero)
        sender.renderFavoriteButton(hero: hero)
    }
    var hero: HeroModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameHeroDetail.text = hero.name
        nameDescriptionDetail.text = hero.description == "" ? "\(hero.name) don't have a description." : hero.description
        imageHeroDetail.kf.setImage(with: URL(string: self.hero.thumbnail.url))
        buttonFavoriteDetail.renderFavoriteButton(hero: hero)
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
