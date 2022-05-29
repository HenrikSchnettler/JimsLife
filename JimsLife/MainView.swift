//
//  ContentView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 07.04.21.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UINavigationBar.appearance().barTintColor = .clear
        //UITabBar.appearance().barTintColor = UIColor.themeTabview
    }
    @State private var selection = 0
    
    var body : some View{
        TabView(selection: $selection){
                //Übersicht Tab
                HomeView()
                    .tag(0)
            
                .tabItem {
                    Text("Übersicht")
                    Image(systemName: "house")
                    Color.themeAccent
                }
                
                //Social Tab
                ProgressView()
                    .tag(1)
    
                    .tabItem {
                        Image(systemName: "person.3")
                        Text("Soical")
                    }
                //Fortschritt Tab
                ProgressView()
                    .tag(1)
        
                .tabItem {
                    Image(systemName: "flame")
                    Text("Mein Fortschritt")
                }
        }
        .font(Font.headline)
        .accentColor(Color.themeAccent)
        
            
            
            
            
        
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
