//
//  Supplements.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 28.01.23.
//

import Foundation
import CoreData

extension DoneSupplements {
    static var fetchAllDoneSupplements: NSFetchRequest<DoneSupplements> {
        let request: NSFetchRequest<DoneSupplements> = DoneSupplements.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "created _on", ascending: true)]
        request.includesSubentities = true
        return request
    }
}
