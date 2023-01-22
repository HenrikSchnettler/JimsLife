//
//  HomeView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 07.04.21.
//

import SwiftUI
/// Henrik: - HomeView
struct HomeView: View{
    
    var body: some View {
        VStack{
        // Erster Tab (Todo View einbinden aus anderer Datei)
            ZStack{
                //Color.themeBackground
                    //.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment: .leading)
                {
                    //Supplement Picker Row
                    HomeView_Item_Row()
                        //.padding(EdgeInsets())
                    Divider()
                    ScrollView{
                        VStack{
                            HStack{
                                VStack{
                                    Text("weight")
                                        .textCase(.uppercase)
                                        .foregroundColor(Color.themeTertiary)
                                        .bold()
                                    Text("72,5kg")
                                }
                                Divider()
                                VStack{
                                    Text("body fat")
                                        .textCase(.uppercase)
                                        .foregroundColor(Color.secondary)
                                        .bold()
                                    Text("15%")
                                }
                                Divider()
                                Spacer()
                            }
                            .padding()
                            //StatsView
                            TabView{
                                StatsView()
                                StatsView()
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            .frame(height: 160)
                            Spacer()
                        }
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

struct StatsView: View {
    
    var body: some View {
        HStack{
            VStack{
                HStack{
                    NavigationLink(destination: SettingsView())
                    {
                        Image(systemName: "sleep.circle")
                            .resizable()
                            .frame(minWidth: 30, maxWidth: 30, minHeight: 30, maxHeight: 30)
                            .padding()
                            .foregroundColor(Color.themeForeground)
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
                            .foregroundColor(Color.themeForeground)
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
                            .foregroundColor(Color.themeForeground)
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
                            .foregroundColor(Color.themeForeground)
                        ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                            .progressViewStyle(StatsProgressStyle())
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(20)
        }
        .padding()
    }

}

struct HomeView_Item_Row: View {
    @State var showComposeMessageView: Bool = false
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoSupplements.id, ascending: true)],
        animation: .default)
    private var todoSupplementItems: FetchedResults<TodoSupplements>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DoneSupplements.id, ascending: true)],
        animation: .default)
    private var doneSupplementItems: FetchedResults<DoneSupplements>
    
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
                                    .foregroundColor(Color.white)
                                    .frame(width: 30, height: 30)
                            }
                        )
                        .contextMenu{
                            Text("consumed supplements")
                                .foregroundColor(.red)
                                .font(.headline)
                            Divider()
                            HStack{
                                ForEach(doneSupplementItems) { item in
                                    Button{
                                        print("Test")
                                    }label: {
                                        Label(item.name!, systemImage: "minus.circle")
                                    }
                                }
                            }
                        }
                        .onLongPressGesture {
                            print("Test")
                        }
                    ForEach(todoSupplementItems) { item in
                        
                        HomeView_Item(supplement: item)
                    }
                    Button(action: addItem) {
                        Label("add", systemImage: "plus")
                    }
                }
                .padding()
                
            })
            
        }

    }
    
    private func addItem() {
        withAnimation {
            let newItem = TodoSupplements(context: viewContext)
            newItem.id = 0
            newItem.categorie = "Test"
            newItem.imageName = "power.circle"
            newItem.itemDescription = "Test"
            newItem.name = "Test"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct HomeView_Item: View {
    
    var supplement: AnyObject
    var body: some View {
        
        Capsule()
            .fill(Color.themeAccent)
            .frame(minWidth: 125, maxWidth: 200, minHeight: 50, maxHeight: 50)
            .overlay(
                VStack(alignment: .leading){
                    HStack(){
                        Circle()
                            .fill(Color.ContentOverAccent)
                            .frame(minWidth: 25, maxWidth: 40, minHeight: 25, maxHeight: 40)
                            .overlay(
                                Text(supplement.name.prefix(1))
                                    .foregroundColor(Color.InvertedContentOverAccent )
                                    .frame(width: 40, height: 40)
                                    
                            )
                        Text(supplement.name).bold().foregroundColor(Color.ContentOverAccent)
                    }
                }
            )
                .contextMenu{
                    Button{
                        
                    }label: {
                        Label("supplement taken", systemImage: "checkmark.circle")
                    }
                    Button{
                        
                    }label: {
                        Label("remove from list", systemImage: "minus.circle")
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
