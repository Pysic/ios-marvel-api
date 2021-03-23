//
//  CoreDataDetailsViewController.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 22/03/21.
//

import UIKit

class CoreDataDetailsHeroesViewController: UIViewController {

    @IBOutlet weak var nameDescriptionDetail: UITextView!
    @IBOutlet weak var nameHeroDetail: UILabel!
    @IBOutlet weak var imageHeroDetail: UIImageView!

    @IBAction func buttonUnfavoriteDetailClick(_ sender: Any) {
        self.alertHeroDelete(index: index ?? 0)
    }
    
    private func alertHeroDelete(index: Int){
        self.alertModal(title: "Remove Hero", message: "The hero will be removed from favorites.", onOk: {
            CoreDataHandler.shared.deleteByIndex(index: index)
            self.navigationController?.popViewController(animated: true)
        }, onCancel: {
            return
        })
    }
    
    var hero: HeroesData!
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        nameHeroDetail.text = hero.name
        nameDescriptionDetail.text = hero.information == "" ? "\(hero.name ?? "This hero ") don't have a description." : hero.information
        if let image = hero.image as? UIImage {
            imageHeroDetail.image = image
        }
        // Do any additional setup after loading the view.
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
