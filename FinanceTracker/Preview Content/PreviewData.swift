//
//  PreviewData.swift
//  FinanceTracker
//
//  Created by Luís Teixeira on 28.01.23.
//

import Foundation

class PreviewData {
    
    static func load<T:Codable>(name: String) -> [T] {
        
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let results = try JSONDecoder().decode([T].self, from: data)
                return results
            } catch let error{
                print(error.localizedDescription)
                return[]
            }
        }
        return []
    }
}
