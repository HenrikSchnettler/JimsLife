//
//  SupplementInfoView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 19.02.23.
//

import SwiftUI
import Combine
import CoreData

struct SupplementInfoView: View {
    let context: NSManagedObjectContext
    let supplement: Supplements
    
    var body: some View {
        NavigationView{
            VStack{
                
            }
            .navigationTitle(supplement.name!)
        }
    }
}

struct SupplementInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SupplementInfoView(context: NSManagedObjectContext(), supplement: Supplements())
    }
}
