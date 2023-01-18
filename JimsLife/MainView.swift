//
//  ContentView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 07.04.21.
//

import SwiftUI

enum Tabs: String{
    case home = "appname"
    case social = "social"
    case progress = "progress"
    
    var localizedString: String {
        switch self {
            case .home:
                return NSLocalizedString("appname", comment: "")
            case .social:
                return NSLocalizedString("social", comment: "")
            case .progress:
                return NSLocalizedString("progress", comment: "")
        }
    }
}


struct MainView: View {
    
    init() {
        
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
                        Text("overview")
                        Image(systemName: "house")
                        Color.themeAccent
                    }
                    
                    //Social Tab
                    ProgressionView()
                    .tag(Tabs.social)
                        
                    .tabItem {
                        Image(systemName: "person.3")
                        Text("social")
                    }
                    //Fortschritt Tab
                    ProgressionView()
                    .tag(Tabs.progress)
                
                    .tabItem {
                        Image(systemName: "flame")
                        Text("progress")
                        //Text(LocalizedStringKey("progress"))
                    }
            }
            .onAppear(){
                
            }
            //.background(VisualEffectBlur())
            .navigationTitle(selection.localizedString.capitalized)
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
                    Color.themeLabel.opacity(0)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    HStack(){
                        VStack(){
                            //Account Card
                            HStack{
                                ZStack{
                                    Circle()
                                        .foregroundColor(Color.ContentOverAccent)
                                        .frame(width: 70, height: 70, alignment: .center)
                                        .padding()
                                    Text("HS")
                                        .foregroundColor(Color.InvertedContentOverAccent)
                                        .frame(width: 70, height: 70, alignment: .center)
                                }
                                VStack{
                                    Text("Henrik Schnettler")
                                        .foregroundColor(Color.ContentOverAccent)
                                    Text(verbatim:"henrik@schnettler.dev")
                                        .foregroundColor(Color.ContentOverAccent)
                                    Divider()
                                        .frame(width: 225, height: 10, alignment: .leading)
                                    Text("Mitgliedschaft: Premium")
                                        .foregroundColor(Color.ContentOverAccent)
                                }
                
                            }
                            .frame(height: 150)
                            .background(Color.themeSecondary)
                            .cornerRadius(20)
                            .padding()
                            
                            //Uebersicht Card
                            
                            List {
                                Section(header: Text("overview")){
                                    NavigationLink(destination: SettingsView())
                                    {
                                        Text("my supplements")
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
                .navigationTitle("account")
                .navigationBarTitleDisplayMode(.inline)
                .compositingGroup()
                //.opacity(0.6)
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
