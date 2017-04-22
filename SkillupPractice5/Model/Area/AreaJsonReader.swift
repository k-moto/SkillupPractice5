//
//  AreaJsonReader.swift
//  SkillupPractice5
//
//  Created by k_motoyama on 2017/04/22.
//  Copyright © 2017年 k_moto. All rights reserved.
//

import Foundation
import ObjectMapper

class AreaJsonReader {
    
    var loadable: AreaLoadable?
    
    func parseJsonData() {
        
        let bundle = Bundle(for: type(of: self))
        let filePath = bundle.path(forResource: "area", ofType: "json")
        
        if let path = filePath {
            
            let fileHandle = FileHandle(forReadingAtPath: path)
            let jsonData = fileHandle?.readDataToEndOfFile()
            
            if let jsonData = jsonData {
                
                let json = String(data: jsonData,
                                  encoding: String.Encoding.utf8)
                
                if let json = json {
                    
                    if let searchResult = Mapper<AreaResult>().map(JSONString: json) {
                        let result = self.setResult(result: searchResult)
                        self.loadable?.setResult(result: result)
                        return
                        
                    }
                }
            }
            
            self.loadable?.setResult(result: .error())
            return
        }
    }
    
    private func setResult(result: AreaResult) -> AreaStatus {
        return result.gareaLarge.isEmpty ? .noData : .nomal(result)
    }
}
