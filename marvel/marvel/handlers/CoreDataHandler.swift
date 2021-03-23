//
//  CoreDataHandler.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 22/03/21.
//

import Foundation
import UIKit
import CoreData

class CoreDataHandler: UIViewController {
    
    var heroData: HeroesData!
    var heroes: [HeroesData] = []
    static let shared = CoreDataHandler()
    
    func insertHero(hero: HeroModel){
//        if(heroData == nil){
//            heroData = HeroesData(context: coreDataContext)
//        }
        heroData = HeroesData(context: coreDataContext)
        heroData.id = Int64(hero.id)
        heroData.name = hero.name
        heroData.information = hero.description

        let imageUrl:URL = URL(string: hero.thumbnail.url)!
        let imageData:NSData = NSData(contentsOf: imageUrl)!
        let image = UIImage(data: imageData as Data)
        heroData.image = image

        do{
            try coreDataContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteHero(index: Int) {
        let hero = heroes[index]
        coreDataContext.delete(hero)
        
        do {
            try coreDataContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadHeroes() {
        let fetchRequest: NSFetchRequest<HeroesData> = HeroesData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do{
            heroes = try coreDataContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
}
