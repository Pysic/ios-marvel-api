//
//  ViewController.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 17/03/21.
//

import UIKit

class SearchHeroesViewController: UIViewController {

    private var heroes: [HeroModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        HttpRequestApiService().getHeroes(okStatus: { (response) in
            self.heroes = response
            
            for hero in self.heroes {
                print(hero.name)
            }
        })
        // Do any additional setup after loading the view.
    }
}
