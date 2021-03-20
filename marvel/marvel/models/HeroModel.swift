//
//  File.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 18/03/21.
//

import Foundation

class HeroModel : Codable{
    var id: Int
    var name: String
    var description: String
    var thumbnail: ThumbnailModel
}
