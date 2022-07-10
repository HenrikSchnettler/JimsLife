//
//  ContentView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 07.04.21.
//

import SwiftUI

enum Tabs: String{
    case home = "Jim´s Life"
    case social = "Social Club"
    case progress = "Mein Fortschitt"
}


struct MainView: View {
    
    init() {
        //UINavigationBar.appearance().barTintColor = .clear
       // UITabBar.appearance().barTintColor = UIColor.themeTabview
    }
    @State var selection: Tabs = .home
    @State var showComposeMessageView: Bool = false
    
    var body : some View{
        NavigationView{
            TabView(selection: $selection){
                    //Übersicht Tab
                    HomeView()
                    .tag(Tabs.home)
                
                    .tabItem {
                        Text("Übersicht")
                        Image(systemName: "house")
                        Color.themeAccent
                    }
                    
                    //Social Tab
                    ProgressionView()
                    .tag(Tabs.social)
                        
                    .tabItem {
                        Image(systemName: "person.3")
                        Text("Soical")
                    }
                    //Fortschritt Tab
                    ProgressionView()
                    .tag(Tabs.progress)
                    .tabItem {
                        Image(systemName: "flame")
                        Text("Mein Fortschritt")
                    }
            }
            .onAppear(){
                
            }
            //.background(VisualEffectBlur())
            .navigationTitle(selection.rawValue.capitalized)
            .navigationBarItems(trailing:
                                    ZStack{
                                        Button(action: {
                                            showComposeMessageView.toggle()
                                        }, label: {
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(Color.themeForeground )
                                                    .frame(width: 42, height: 42, alignment: .center)
                                                Text("HS")
                                                    .foregroundColor(Color.themeBackground)
                                            }
                                        })
                                        //Circle()
                                            //.strokeBorder(lineWidth: 4)
                                    }
            )
            .font(Font.headline)
            .accentColor(Color.themeAccent)
        
        }
        .sheet(isPresented: $showComposeMessageView, content: {
            NavigationView{
                ZStack {
                    //Color.themeBackground
                        //.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    HStack(){
                        VStack(){
                            //Account Card
                            ZStack{
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.themeLabel.opacity(0.1))
                                    .frame(width: 360, height: 110, alignment: .leading)
                                HStack{
                                    ZStack{
                                        Circle()
                                            .foregroundColor(Color.themeLabel)
                                            .frame(width: 70, height: 70, alignment: .center)
                                            .padding()
                                        Text("HS")
                                            .foregroundColor(Color.themeBackground)
                                            .frame(width: 70, height: 70, alignment: .center)
                                    }
                                    VStack{
                                        Text("Henrik Schnettler")
                                        Text("henrik@schnettler.dev")
                                        Divider()
                                            .frame(width: 225, height: 10, alignment: .leading)
                                        Text("Mitgliedschaft: Premium")
                                    }
                    
                                }
                            }
                            .padding(.top, 10)
                            
                            //Uebersicht Card
                            
                            List {
                                Section(header: Text("Übersicht")){
                                    NavigationLink(destination: SettingsView())
                                    {
                                        Text("Meine Supplements")
                                    }
                                    Text("Test2")
                                }
                            }
                            .frame(width: 400)
                            //.padding(.top, 10)
                            Spacer()
                        }
                    }
                }
                .navigationTitle("Account")
                .compositingGroup()
                .opacity(0.6)
            }
        })
            
            
            
            
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
