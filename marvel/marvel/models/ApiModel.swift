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
    var results: [HeroModel]
}

struct HeroModel : Codable{
    var id: Int
    var name: String
    var description: String
    var thumbnail: ThumbnailModel
}

struct ThumbnailModel : Codable{
    var path: String
    var `extension`: String
}

