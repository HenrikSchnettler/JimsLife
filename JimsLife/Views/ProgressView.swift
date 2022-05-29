//
//  ProgressView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 07.04.21.
//

import SwiftUI

struct ProgressView: View{
    
    @State var showComposeMessageView: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.themeBackground
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            // Erster Tab (Todo View einbinden aus anderer Datei)
                Text("Fortschritt meines Körpers")
                .navigationTitle("Mein Fortschritt")
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
                                        .padding()
                                        
                )
            }
        }
        .sheet(isPresented: $showComposeMessageView, content: {
            ZStack {
                Color.themeBackground
                VStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipped()
                        .padding()
                        .foregroundColor(Color.themeAccent)
                        .cornerRadius(150)
                        .shadow(radius: 3)
                    Text("Henrik Schnettler")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.medium)
                    Text("Premium Mitgliedschaft")
                        .font(.footnote)
                    Spacer()
                }
            }
        })
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
