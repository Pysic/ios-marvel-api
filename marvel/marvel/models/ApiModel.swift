//
//  HeroModel.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 18/03/21.
//

import Foundation

struct ApiModel : Codable {
  var data: DataModel
}

struct DataModel : Codable {
    var total: Int
    var results: [HeroModel]
}

struct HeroModel : Codable{
    var id: Int
    var name: String
    var description: String
    var thumbnail: ThumbnailModel
    var favorite: Bool {
        CoreDataHandler().checkSaved(id: id)
    }
}

struct ThumbnailModel : Codable{
    var path: String
    var `extension`: String
    
    var url: String {
        "\(path).\(`extension`)"
    }
}

