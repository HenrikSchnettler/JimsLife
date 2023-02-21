//
//  ProgressView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 07.04.21.
//

import SwiftUI

struct ProgressionView: View{
    
    @State var showComposeMessageView: Bool = false
    
    var body: some View {
        
        ZStack{
            Color.themeBackground
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            // Erster Tab (Todo View einbinden aus anderer Datei)
            Text("Fortschritt meines Körpers")
            .listStyle(GroupedListStyle())
            
        }
    }
}

struct ProgressionView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressionView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
