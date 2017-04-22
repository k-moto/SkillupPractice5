//
//  AreaResult.swift
//  guru
//
//  Created by k_motoyama on 2017/04/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import ObjectMapper

struct AreaResult: Mappable {
    
    var gareaLarge: [AreaItem] = []
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        gareaLarge <- map["garea_large"]
        
    }
}
