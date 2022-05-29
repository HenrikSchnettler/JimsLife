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
        NavigationView{
            // Erster Tab (Todo View einbinden aus anderer Datei)
            ZStack{
                Color.themeBackground
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment: .leading)
                {
                    HomeView_Item_Row(supplements: SupplementData)
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
                    
                    ForEach(0 ..< supplements.count){
                        number in
                        HomeView_Item(supplement: supplements[number])
                    }
                    
                }
                
            })
            .padding()
            Spacer()
        }

    }
}

struct HomeView_Item: View {
    
    var supplement: Supplement
    
    var body: some View {
        
        Capsule()
            .fill(Color.themeAccent)
            .frame(minWidth: 125, maxWidth: 150, minHeight: 50, maxHeight: 50)
            .overlay(
                HStack{
                    Image(systemName: supplement.icon)
                        .resizable()
                        .foregroundColor(Color.themeForeground )
                        .frame(width: 40, height: 40)
                    
                    Text(supplement.name).bold().foregroundColor(.white)
                }
            )
                    
            
    }

}




struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            
            
    }
}
