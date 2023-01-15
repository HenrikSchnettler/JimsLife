//
//  SettingsView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 02.07.22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView{
            HStack(alignment: .top){
                VStack{
                    List{
                        Section(header: Text("active supplements:")){
                            Text("Aktives Supplement 1")
                            Text("Aktives Supplement 2")
                            
                        }
                        Section(header: Text("more possible supplements:")){
                            Text("Mögliches Supplement 1")
                            Text("Mögliches Supplement 2")
                        }
                    }
                }
            }
            Spacer()
        }.navigationTitle("my supplements")
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
