//
//  HomeView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 07.04.21.
//

import SwiftUI
import CoreData
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
       
            VStack{
                HStack{
                    NavigationLink(destination: SettingsView())
                    {
                        Image(systemName: "sleep.circle")
                            .resizable()
                            .frame(minWidth: 25, maxWidth: 30, minHeight: 25, maxHeight: 30)
                            .fixedSize(horizontal: true, vertical: true)
                            .padding(.horizontal,10)
                            .foregroundColor(Color.themeForeground)
                        ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                            .progressViewStyle(StatsProgressStyle())
                            .foregroundColor(.red)
                            .padding(.horizontal,10)
                    }
                    
                    NavigationLink(destination: SettingsView())
                    {
                        Image(systemName: "sleep.circle")
                            .resizable()
                            .frame(minWidth: 25, maxWidth: 30, minHeight: 25, maxHeight: 30)
                            .fixedSize(horizontal: true, vertical: true)
                            .padding(.horizontal,10)
                            .foregroundColor(Color.themeForeground)
                        ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                            .progressViewStyle(StatsProgressStyle())
                            .foregroundColor(.red)
                            .padding(.horizontal,10)
                    }
                    
                    
                }
                .padding()
                HStack{
                    NavigationLink(destination: SettingsView())
                    {
                        Image(systemName: "sleep.circle")
                            .resizable()
                            .frame(minWidth: 25, maxWidth: 30, minHeight: 25, maxHeight: 30)
                            .fixedSize(horizontal: true, vertical: true)
                            .padding(.horizontal,10)
                            .foregroundColor(Color.themeForeground)
                        ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                            .progressViewStyle(StatsProgressStyle())
                            .foregroundColor(.red)
                            .padding(.horizontal,10)
                    }
                    
                    NavigationLink(destination: SettingsView())
                    {
                        Image(systemName: "sleep.circle")
                            .resizable()
                            .frame(minWidth: 25, maxWidth: 30, minHeight: 25, maxHeight: 30)
                            .fixedSize(horizontal: true, vertical: true)
                            .padding(.horizontal,10)
                            .foregroundColor(Color.themeForeground)
                        ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
                            .progressViewStyle(StatsProgressStyle())
                            .foregroundColor(.red)
                            .padding(.horizontal,10)
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(20)
            .padding()
        
        
    }

}

struct HomeView_Item_Row: View {
    @State var showComposeMessageView: Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    
    //Todo supplements are fetched
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoSupplements.quantity_left, ascending: true)],
        animation: .easeIn)
    private var todoSupplementItems: FetchedResults<TodoSupplements>
    
    //Done supplements are fetched
    @FetchRequest(fetchRequest: DoneSupplements.fetchAllDoneSupplements)
    private var doneSupplementItems: FetchedResults<DoneSupplements>
    
    var body: some View {
        VStack(alignment: .leading){
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(){
                    //supplements which are taken before are listed here
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
                                    Button(role: .destructive){
                                        TodoSupplements.addObject(objectToAdd: item.linkedsupplements!, from: viewContext)
                                        DoneSupplements.removeObject(object: item, from: viewContext)
                                    }label: {
                                        Label(item.supplements?.name ?? "", systemImage: "minus.circle")
                                    }
                                }
                            }
                        }
                        .onLongPressGesture {
                            print("Test")
                        }
                    ForEach(todoSupplementItems) { item in
                        HomeView_Item(context: viewContext, supplement: item.supplements!)
                    }
                    NavigationLink(destination: SettingsView()) {
                        Label("add", systemImage: "plus")
                    }
                }
                .padding()
                
            })
            
        }

    }
}

struct HomeView_Item: View {
    var context: NSManagedObjectContext
    var supplement: Supplements

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
                                Text(supplement.name!.prefix(1))
                                    .foregroundColor(Color.InvertedContentOverAccent )
                                    .frame(width: 40, height: 40)
                                    
                            )
                        Text(supplement.name!).bold().foregroundColor(Color.ContentOverAccent)
                    }
                }
            )
            .contextMenu{
                Button{
                    //add Supplement to todays done supplements
                    DoneSupplements.addObject(objectToAdd: supplement.linkedsupplements!, from: context)
                    //remove the supplement from the todoSupplement Store
                    TodoSupplements.removeObject(object: supplement.todosupplements!, from: context)
                }label: {
                    Label("supplement taken", systemImage: "checkmark.circle")
                }
                Button(role: .destructive){
                    //only remove the supplement from todays todo store because it´s skipped today
                    TodoSupplements.removeObject(object: supplement.todosupplements!, from: context)
                }label: {
                    Label("skip", systemImage: "minus.circle")
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
