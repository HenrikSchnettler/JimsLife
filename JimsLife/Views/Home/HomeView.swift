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
                    NavigationLink(destination: MySupplementsView())
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
                    
                    NavigationLink(destination: MySupplementsView())
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
                    NavigationLink(destination: MySupplementsView())
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
                    
                    NavigationLink(destination: MySupplementsView())
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
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoSupplements.quantity_left, ascending: false)],
        animation: .easeIn)
    private var todoSupplementItems: FetchedResults<TodoSupplements>
    
    //Skipped supplements are fetched
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SkippedSupplements.supplements?.name, ascending: true)],
        animation: .easeIn)
    private var skippedSupplementItems: FetchedResults<SkippedSupplements>
    
    //Done supplements are fetched
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DoneSupplements.supplements?.name, ascending: true)],
        animation: .easeIn)
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
                            VStack{
                                Section(){
                                    Text("consumed supplements")
                                        .foregroundColor(.green)
                                        .font(.headline)
                                    ForEach(doneSupplementItems) { item in
                                        Button(role: .destructive){
                                            TodoSupplements.addObject(objectToAdd: item.linkedsupplements!, from: viewContext)
                                            DoneSupplements.removeObject(object: item, from: viewContext)
                                        }label: {
                                            Label(item.supplements?.name ?? "", systemImage: "minus.circle")
                                        }
                                    }
                                }
                                Divider()
                                Section(){
                                    Text("skipped supplements")
                                        .foregroundColor(.red)
                                        .font(.headline)
                                    ForEach(skippedSupplementItems) { item in
                                        Button(role: .destructive){
                                            TodoSupplements.addObject(objectToAdd: item.linkedsupplements!, from: viewContext)
                                            SkippedSupplements.removeObject(object: item, from: viewContext)
                                        }label: {
                                            Label(item.supplements?.name ?? "", systemImage: "minus.circle")
                                        }
                                    }
                                }
                            }
                            
                        }
                        .onLongPressGesture {
                            print("Test")
                        }
                    ForEach(todoSupplementItems) { item in
                        HomeView_Item(context: viewContext, todosupplement: item, supplement: item.supplements!)
                    }
                    NavigationLink(destination: MySupplementsView()) {
                        Label("add", systemImage: "plus")
                    }
                }
                .padding()
                
            })
            
        }

    }
}

struct HomeView_Item: View {
    let context: NSManagedObjectContext
    let todosupplement: TodoSupplements
    let supplement: Supplements
    
    @State private var activeSupplement: Supplements?

    var body: some View {
        ZStack{
            Capsule()
                .fill(Color.themeAccent)
                .frame(minWidth: 150, maxWidth: 400, minHeight: 50, maxHeight: 50)
                .overlay(
                    VStack(){
                        HStack(){
                            Circle()
                                .fill(Color.ContentOverAccent)
                                .frame(minWidth: 25, maxWidth: 40, minHeight: 50, maxHeight: 50)
                                .overlay(
                                    Text(supplement.name!.prefix(2).uppercased())
                                        .foregroundColor(Color.InvertedContentOverAccent )
                                        .frame(width: 40, height: 40)
                                    
                                )
                                .position(x:25,y:25)
                            Text(supplement.name!).bold().foregroundColor(Color.ContentOverAccent)
                                .position(x:10,y:25)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                )
                .padding(.vertical,10)
                .padding(.horizontal,2.5)
            Circle()
                .fill(Color.themeSecondary)
                .overlay(
                    Text(String(todosupplement.quantity_left))
                        .foregroundColor(Color.ContentOverAccent )
                        .frame(width: 40, height: 40)
                    
                )
                .frame(minWidth: 25, maxWidth: 25, minHeight: 25, maxHeight: 25)
                .offset(x: 65, y: -17)
        }
        .onTapGesture {
            //the binding variable is set to the clicked item which automatically triggers the sheet
            activeSupplement = supplement
        }
        .sheet(item: $activeSupplement, onDismiss: {
            activeSupplement = nil
        }) { item in
            
            SupplementInfoView(context: context, supplement: item)
            .onTapGesture {
                activeSupplement = nil
            }
        }
        .contextMenu{
            Button{
                //check if supplement is completly done or quantity left has to be decreased
                if(todosupplement.quantity_left - 1 == 0)
                {
                    //quantity left is set to zero
                    todosupplement.setQuantityLeft(quantityLeft: 0)
                    //add Supplement to todays done supplements
                    DoneSupplements.addObject(objectToAdd: supplement.linkedsupplements!, from: context)
                    //remove the supplement from the todoSupplement Store
                    TodoSupplements.removeObject(object: todosupplement, from: context)
                }
                else{
                    //quantity left is set to zero
                    todosupplement.setQuantityLeft(quantityLeft: todosupplement.quantity_left  - 1)
                }
            }label: {
                Label("supplement taken", systemImage: "checkmark.circle")
            }
            Button(role: .destructive){
                //add supplements to skipped supplements
                SkippedSupplements.addObject(objectToAdd: supplement.linkedsupplements!, from: context)
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
