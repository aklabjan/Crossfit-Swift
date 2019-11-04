//
//  lift.swift
//  Crossfit
//
//  Created by Ana Klabjan on 4/26/19.
//  Copyright © 2019 Ana Klabjan. All rights reserved.
//

import Foundation
class lift: Codable
{
    var name: String
    var best: Int
    
    init(name: String, best: Int)
    {
        self.name = name
        self.best = best
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case best
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        best = try container.decode(Int.self, forKey: .best)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(best, forKey: .best)
    }
    
}
