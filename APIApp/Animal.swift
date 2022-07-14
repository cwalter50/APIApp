//
//  Animal.swift
//  APIApp
//
//  Created by Christopher Walter on 2/23/22.
//  Copyright © 2022 DocsApps. All rights reserved.
//

import Foundation


struct Animal: Codable
{
    var name: String
    var latin_name: String
    var lifespan: String
    var animal_type: String
    var image_link: String
    var active_time: String
    var geo_range: String
    var habitat: String
    var diet: String
    var id: Int
}
