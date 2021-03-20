//
//  CreateApiUrl.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 18/03/21.
//

import Foundation

class ApiUrlHandler {
    private let privateKey: String = API_KEYS.PRIVATE.rawValue
    private let publicKey: String = API_KEYS.PUBLIC.rawValue
    private let urlBase: URLS
    private let params: PARAMETERS
    private let pageNumber: Int
    private var heroName: String = ""
    private var attribute: String
    
    private var timestamp: String {
        String(Int64(Date().timeIntervalSince1970 * 1000))
    }
    
    private var hexMd5: String {
        let concatenateKeys = timestamp+privateKey+publicKey
        return ApiUrlUtils().encodeMD5(concatenateStringKeys: concatenateKeys).map { String(format: "%02hhx", $0) }.joined()
    }
    
    init() {
        self.urlBase = URLS.CHARACTERS
        self.params = PARAMETERS.HOME_CHARACTERS
        self.pageNumber = ApiUrlUtils().getPageCount()
        self.attribute = String(pageNumber)
    }
    
    init(heroName name: String) {
        self.urlBase = URLS.CHARACTERS
        self.params = PARAMETERS.CHARACTERS_BY_NAME
        self.pageNumber = 0
        self.heroName = name.replacingOccurrences(of: " ", with: "%20")
        self.attribute = heroName
    }
    
    public func getPath() -> String{
        "\(urlBase.rawValue)ts=\(timestamp)&apikey=\(publicKey)&hash=\(hexMd5)\(params.rawValue)\(attribute)"
    }
}
