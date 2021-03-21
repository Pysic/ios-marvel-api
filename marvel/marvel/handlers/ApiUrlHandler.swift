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
    private let urlBase: URLS = URLS.CHARACTERS
    private let params: PARAMETERS
    private let limit: Int = ApiUrlUtils().getLimit()
    private let pageNumber: Int = ApiUrlUtils().getPageCount()
    private var heroName: String = ""
    
    private var timestamp: String {
        String(Int64(Date().timeIntervalSince1970 * 1000))
    }
    
    private var hexMd5: String {
        let concatenateKeys = timestamp+privateKey+publicKey
        return ApiUrlUtils().encodeMD5(concatenateStringKeys: concatenateKeys).map { String(format: "%02hhx", $0) }.joined()
    }
    
    init() {
        self.params = PARAMETERS.HOME_CHARACTERS
    }
    
    init(heroName name: String) {
        self.params = PARAMETERS.CHARACTERS_BY_NAME
        self.heroName = name.replacingOccurrences(of: " ", with: "%20")
    }
    
    public func getPath() -> String{
        print("\(urlBase.rawValue)ts=\(timestamp)&apikey=\(publicKey)&hash=\(hexMd5)&limit\(limit)&offset\(pageNumber)\(params.rawValue)\(heroName)")
        return "\(urlBase.rawValue)ts=\(timestamp)&apikey=\(publicKey)&hash=\(hexMd5)&limit=\(limit)&offset=\(pageNumber)\(params.rawValue)\(heroName)"
    }
}
