//
//  HomeView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 07.04.21.
//

import SwiftUI
/// Henrik: - HomeView
struct HomeView: View{
    
    @State var showComposeMessageView: Bool = false
    
    var body: some View {
        VStack{
        // Erster Tab (Todo View einbinden aus anderer Datei)
            ZStack{
                //Color.themeBackground
                    //.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment: .leading)
                {
                    //Supplement Picker Row
                    HomeView_Item_Row(supplements: SupplementData)
                    Divider()
                    ScrollView{
                        //StatsView
                        VStack{
                            HStack{
                                NavigationLink(destination: SettingsView())
                                {
                                    Image(systemName: "sleep.circle")
                                        .resizable()
                                        .frame(minWidth: 30, maxWidth: 30, minHeight: 30, maxHeight: 30)
                                        .padding()
                                        .foregroundColor(.white)
                                    ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                                        .progressViewStyle(StatsProgressStyle())
                                        .foregroundColor(.red)
                                        .padding()
                                }
                                
                                NavigationLink(destination: SettingsView())
                                {
                                    Image(systemName: "sleep.circle")
                                        .resizable()
                                        .frame(minWidth: 30, maxWidth: 30, minHeight: 30, maxHeight: 30)
                                        .padding()
                                        .foregroundColor(.white)
                                    ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                                        .progressViewStyle(StatsProgressStyle())
                                        .foregroundColor(.red)
                                        .padding()
                                }
                            }
                            HStack{
                                NavigationLink(destination: SettingsView())
                                {
                                    Image(systemName: "sleep.circle")
                                        .resizable()
                                        .frame(minWidth: 30, maxWidth: 30, minHeight: 30, maxHeight: 30)
                                        .padding()
                                        .foregroundColor(.white)
                                    ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                                        .progressViewStyle(StatsProgressStyle())
                                        .foregroundColor(.red)
                                        .padding()
                                }
                                NavigationLink(destination: SettingsView())
                                {
                                    Image(systemName: "sleep.circle")
                                        .resizable()
                                        .frame(minWidth: 30, maxWidth: 30, minHeight: 30, maxHeight: 30)
                                        .padding()
                                        .foregroundColor(.white)
                                    ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                                        .progressViewStyle(StatsProgressStyle())
                                        .foregroundColor(.red)
                                        .padding()
                                }
                            }
                        }
                        Divider()
                        VStack(alignment: .leading){
                            HStack{
                                //Text("Heutiges Training:")
                                //Text("Push & Beine")
                            }
                            Divider()
                        }
                        .padding()
                        Spacer()
                    }
                }
                .listStyle(GroupedListStyle())
                        
            }
        }
    }
    
}

struct StatsProgressStyle: ProgressViewStyle{
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 14)
                .frame(width: 90, height: 10)
                .foregroundColor(.black)
                .overlay(Color.white.opacity(0.2)).cornerRadius(14)
            
            RoundedRectangle(cornerRadius: 14)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 90, height: 10)
                .foregroundColor(Color.themeAccent)
        }
       
    }
    
    
    
}

struct HomeView_Item_Row: View {
    
    var supplements: [Supplement]
    
    var body: some View {
        VStack(alignment: .leading){
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(){
                    //Supplements, welche schon genommen wurden, werden hier gestapelt
                    Capsule()
                        .fill(Color.themeSecondary)
                        .frame(minWidth: 50, maxWidth: 150, minHeight: 50, maxHeight: 50)
                        .overlay(
                            HStack{
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color.themeForeground )
                                    .frame(width: 30, height: 30)
                            }
                        )
                        .contextMenu{
                            Text("Konsumierte Supplements")
                                .foregroundColor(.red)
                                .font(.headline)
                            Divider()
                            HStack{
                                ForEach(0 ..< supplements.count){
                                    number in
                                        Button{
                                            print("Test")
                                        }label: {
                                            Label(supplements[number].name, systemImage: "minus.circle")
                                        }
                                    
                                }
                            }
                        }
                        .onLongPressGesture {
                            print("Test")
                        }
                    
                    ForEach(0 ..< supplements.count){
                        number in
                        HomeView_Item(supplement: supplements[number])
                    }
                    
                }
                
            })
            .padding()
        }

    }
}

struct HomeView_Item: View {
    
    var supplement: Supplement
    
    var body: some View {
        
        Capsule()
            .fill(Color.themeAccent)
            .frame(minWidth: 125, maxWidth: 200, minHeight: 50, maxHeight: 50)
            .overlay(
                VStack(alignment: .leading){
                    HStack(){
                        Capsule()
                            .fill(Color.themeForeground)
                            .frame(minWidth: 25, maxWidth: 40, minHeight: 25, maxHeight: 40)
                            .overlay(
                                Text(supplement.name.prefix(1))
                                    .foregroundColor(Color.themeSecondary )
                                    .frame(width: 40, height: 40)
                                    
                            )
                        Text(supplement.name).bold().foregroundColor(.white)
                    }
                }
            )
                .contextMenu{
                    Button{
                        
                    }label: {
                        Label("Supplement genommen", systemImage: "checkmark.circle")
                    }
                    Button{
                        
                    }label: {
                        Label("Aus meiner Liste entfernen", systemImage: "minus.circle")
                    }
                }
    }

}




struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            
            
    }
}
