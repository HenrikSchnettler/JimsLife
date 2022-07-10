//
//  DataDecoder.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 17.04.21.
//

import Foundation

let SupplementData: [Supplement] = load(filename: "Supplements.json")
let DoneSupplementData: [DoneSupplement] = load(filename: "DoneSupplements.json")

func load<T:Decodable>( filename:String, as type:T.Type = T.self) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn´t find \(filename) in main bundle")
    }
    
    do{
        data = try Data(contentsOf: file)
    } catch{
        fatalError("Couldnt load \(filename) from main bundle: \(error)")
    }
    
    do{
        let decoder = JSONDecoder() 
        return try decoder.decode(T.self, from:data)
    } catch{
        fatalError("Couldnt parse \(filename) as \(T.self):\n\(error)")
    }
}
