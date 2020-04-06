//
//  Spells.swift
//  Wand
//
//  Created by Heesu Yun on 4/7/20.
//  Copyright © 2020 Heesu Yun. All rights reserved.
//

import Foundation

class Spells {
    
    private struct Results: Codable {
        var url: String
        var name: String
        var soundFile: String
        var description: String
    }
    
    var spellArray: [SpellData] = []
    var url = "https://potterspells.herokuapp.com/api/v1/spells"
    var name = ""
    var soundFile = ""
    var description = ""
    
    
    func getData(completed: @escaping () -> ()) {
        let urlString = url
        print("🕸 We are accessing the url \(urlString)")
        //Create a URL
        guard let url = URL(string: urlString) else{
            print("😡 ERROR: could not create URL from \(urlString)")
            completed()
            return
        }
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("😡 ERROR: \(error.localizedDescription)")
            }
            
            do {
                let results = try JSONDecoder().decode(Results.self, from: data!)
                self.name = results.name
                self.soundFile = results.soundFile
                self.description = results.description
                
                print("This is what we returned from getData: \(self.spellArray)")
            } catch {
                print("😡 JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
    
}
