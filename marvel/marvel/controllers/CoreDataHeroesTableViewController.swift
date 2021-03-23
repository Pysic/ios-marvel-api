//
//  CoreDataHeroesTableViewController.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 22/03/21.
//

import UIKit

class CoreDataHeroesTableViewController: UITableViewController {

    private var heroes: [HeroesData] = CoreDataHandler.shared.heroes
    private var alertLabel = UILabel()
    
    @IBAction func buttonFavoriteClick(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint(), to:tableView)
        let indexPath = tableView.indexPathForRow(at:buttonPosition)
        CoreDataHandler.shared.deleteHero(index: indexPath?.row ?? 0)
        loadHeroes()
    }
    
    private func loadHeroes(){
        CoreDataHandler.shared.loadHeroes()
        heroes = CoreDataHandler.shared.heroes
        print("caiu")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let details = segue.destination as? CoreDataDetailsHeroesViewController {
            let hero = heroes[tableView.indexPathForSelectedRow?.row ?? 0]
            details.hero = hero
            details.index = tableView.indexPathForSelectedRow?.row
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadHeroes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHeroes()
        self.alertLabel.text = "You don't have saved heroes."
        self.alertLabel.textAlignment = .center

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        tableView.backgroundView = heroes.count == 0 ? alertLabel : nil
        return heroes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath)as! CoreDataCellHeroesTableViewController
        
        let hero = heroes[indexPath.row]
        
        cell.renderHero(with: hero)
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
