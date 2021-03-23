//
//  SearchHeroesTableViewController.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 19/03/21.
//

import UIKit

class SearchHeroesTableViewController: UITableViewController {
    
    var heroData: HeroesData!
    private var heroes: [HeroModel] = []
    private var isLoadingHeroes: Bool = false
    private var totalHeroes: Int = 0
    private var indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    private var alertLabel = UILabel()
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchTextFieldChanged(_ sender: UITextField) {
        waitUserStopsTypeToRequest(delay: 0.4)
    }
    
    @IBAction func buttonFavoriteClick(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint(), to:tableView)
        let indexPath = tableView.indexPathForRow(at:buttonPosition)
        let hero = self.heroes[indexPath?.row ?? 0]
        
        hero.favorite ? CoreDataHandler.shared.deleteByHero(hero: hero) : CoreDataHandler.shared.insertHero(hero: hero)
        sender.renderFavoriteButton(hero: hero)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        
        if let details = segue.destination as? SearchDetailsHeroesViewController{
            let hero = heroes[tableView.indexPathForSelectedRow?.row ?? 0]
            details.hero = hero
        }
    }
    
    private func getHeroes(httpRequest: HttpRequestApiService){
        self.isLoadingHeroes = true
        httpRequest.getHeroes(completion: { (responseData) in
            
            self.heroes += responseData.results
            self.totalHeroes = responseData.total
            
            if self.totalHeroes == 0{
                DispatchQueue.main.async {
                    self.alertLabel.text = ALERTS.NO_HERO_FOUND.rawValue
                    self.alertLabel.textAlignment = .center
                }
            }
            
            DispatchQueue.main.async {
                self.view.loaderElement(indicator: self.indicator, show: false)
                self.tableView.reloadData()
            }
            self.isLoadingHeroes = false
        }, onError: { (responseError) in
            switch responseError {
                case .taskError:
                    DispatchQueue.main.async {
                        self.alertLabel.text = ALERTS.NO_INTERNET.rawValue
                    }
                    break
                case .errorResponseCode:
                    DispatchQueue.main.async {
                        self.alertLabel.text = ALERTS.NO_AUTH.rawValue
                    }
                    break
                case .errorData:
                    print("data parse error")
                    break
            }
            DispatchQueue.main.async {
                self.alertLabel.textAlignment = .center
                self.view.loaderElement(indicator: self.indicator, show: false)
            }
            self.isLoadingHeroes = false
        })
    }
    
    private func cleanHeroes(){
        self.view.loaderElement(indicator: indicator, show: true)
        
        self.heroes = []
        ApiUrlUtils().resetPageCount()
        
        self.alertLabel.text = ""
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func waitUserStopsTypeToRequest(delay: Double){
        cleanHeroes()
        
        NSObject.cancelPreviousPerformRequests(
                withTarget: self,
                selector: #selector(SearchHeroesTableViewController.callRequestResolver),
                object: searchTextField)
        self.perform(
            #selector(SearchHeroesTableViewController.callRequestResolver),
            with: searchTextField,
            afterDelay: delay)
    }
    
    @objc private func callRequestResolver(){
        guard let textValue = searchTextField.text else {return}
        let request = textValue == "" ? HttpRequestApiService() : HttpRequestApiService(withHeroName: textValue)
        getHeroes(httpRequest: request)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.loaderElement(indicator: indicator, show: true)
        callRequestResolver()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = heroes.count == 0 ? alertLabel : nil
        return heroes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath) as! SearchCellHeroesTableViewController
        let hero = heroes[indexPath.row]
        
        cell.renderHero(with: hero)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == heroes.count - 5 && !self.isLoadingHeroes && heroes.count != self.totalHeroes) {
            callRequestResolver()
        }
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
