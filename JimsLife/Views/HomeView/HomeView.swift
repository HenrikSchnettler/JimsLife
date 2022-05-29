//
//  HomeView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 17.04.21.
//

import SwiftUI

struct HomeView: View{
    
    @State var showComposeMessageView: Bool = false
    
    var body: some View {
        NavigationView{
            // Erster Tab (Todo View einbinden aus anderer Datei)
            ZStack{
                Color.themeBackground
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment: .leading)
                {
                    HomeView_Item()
                }
                .navigationTitle("Jim´s Life")
                .listStyle(GroupedListStyle())
                .navigationBarItems(trailing:
                                        Button(action: {
                                            showComposeMessageView.toggle()
                                        }, label: {
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .foregroundColor(Color.themeForeground )
                                                .frame(width: 42, height: 42, alignment: .center)
                                                
                                        })
                )
            }
        }
        .sheet(isPresented: $showComposeMessageView, content: {
            ZStack {
               
               Text("Test")
            }
            .compositingGroup()
            .opacity(0.5)
        })
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
