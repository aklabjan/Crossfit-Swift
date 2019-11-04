//
//  Workout.swift
//  Crossfit
//
//  Created by Ana Klabjan on 2/26/19.
//  Copyright © 2019 Ana Klabjan. All rights reserved.
//

import Foundation
class WOD: Codable
{
    var name: String
    var type: String
    var length: Int
    var explanation: String
    var date: String
    
    init(name: String, type: String, length: Int, explanation: String)
    {
        self.name = name
        self.type = type
        self.length = length
        self.explanation = explanation
        date = ""
    }
    
    init(name: String, type: String, length: Int, explanation: String, date: String)
    {
        self.name = name
        self.type = type
        self.length = length
        self.explanation = explanation
        self.date = date
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case length
        case explanation
        case date
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        length = try container.decode(Int.self, forKey: .length)
        explanation = try container.decode(String.self, forKey: .explanation)
        date = try container.decode(String.self, forKey: .date)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(length, forKey: .length)
        try container.encode(type, forKey: .type)
        try container.encode(explanation, forKey: .explanation)
        try container.encode(date, forKey:  .date)
    }
    
}
