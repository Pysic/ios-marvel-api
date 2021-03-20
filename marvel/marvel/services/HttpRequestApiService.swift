//
//  HttpRequestService.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 17/03/21.
//

import Foundation

class HttpRequestApiService{
    private static let session = URLSession.shared
    private var url: String
    
    init(){
        self.url = ApiUrlHandler().getPath()
    }
    
    init(withHeroName name: String) {
        self.url = ApiUrlHandler(heroName: name).getPath()
    }
    
    func getHeroes(completion: @escaping ([HeroModel]) -> Void){
        let urlPath = self.url
        guard let url = URL(string: urlPath) else {return}
        let dataTask = HttpRequestApiService.session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200 { //Requisição status OK
                    guard let data = data else {return}
                    do {
                        let json = try JSONDecoder().decode(ApiModel.self, from: data)
                        completion(json.data.results)
                    } catch {
                        print("error")
                    }
                }
            } else {
                print(error!)
            }
        }
        dataTask.resume()
    }
}
