//
//  SearchHeroesTableViewCellController.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 20/03/21.
//

import UIKit

class SearchCellHeroesTableViewController: UITableViewCell {

    @IBOutlet weak var labelNameHero: UILabel!
    @IBOutlet weak var imageHero: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func renderHero(with hero: HeroModel){
        if(labelNameHero !== nil && imageHero !== nil){
            labelNameHero.text = hero.name
            imageHero.kf.setImage(with: URL(string: hero.thumbnail.url))
        }
    }
}
