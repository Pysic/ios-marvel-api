//
//  CoreDataCellHeroesTableView.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 22/03/21.
//

import UIKit

class CoreDataCellHeroesTableViewController: UITableViewCell {

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
    
    func renderHero(with hero: HeroesData){
        if(labelNameHero !== nil && imageHero !== nil){
            labelNameHero.text = hero.name
            if let image = hero.image as? UIImage {
                imageHero.image = image
            }
        }
    }

}
