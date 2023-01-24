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

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoSupplements.id, ascending: true)],
        animation: .easeIn)
    private var todoSupplementItems: FetchedResults<TodoSupplements>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DoneSupplements.id, ascending: true)],
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
                            Text("consumed supplements")
                                .foregroundColor(.red)
                                .font(.headline)
                            Divider()
                            HStack{
                                ForEach(doneSupplementItems) { item in
                                    Button(role: .destructive){
                                        addBackTodoSupplement(objectToAdd: item)
                                        deleteDoneSupplement(deleteObject: item)
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
                        
                        HomeView_Item(supplement: item, deleteTodoSupplement: {deleteTodoSupplement(deleteObject: item)}, addDoneSupplement: {addDoneSupplement(objectToAdd: item)})
                    }
                    //Button(action: addTodoSupplement) {
                        //Label("add", systemImage: "plus")
                    //}
                }
                .padding()
                
            })
            
        }

    }
    
    private func addBackTodoSupplement(objectToAdd: DoneSupplements) {
        withAnimation {
            let newItem = TodoSupplements(context: viewContext)
            newItem.id = objectToAdd.id
            newItem.categorie = objectToAdd.categorie
            newItem.imageName = objectToAdd.imageName
            newItem.itemDescription = objectToAdd.itemDescription
            newItem.name = objectToAdd.name

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
    
    private func deleteTodoSupplement(deleteObject: TodoSupplements) {
        withAnimation {
            viewContext.delete(deleteObject)
            
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
    
    private func addDoneSupplement(objectToAdd: TodoSupplements) {
        withAnimation {
            let newItem = DoneSupplements(context: viewContext)
            newItem.id = objectToAdd.id
            newItem.categorie = objectToAdd.categorie
            newItem.imageName = objectToAdd.imageName
            newItem.itemDescription = objectToAdd.itemDescription
            newItem.name = objectToAdd.name

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
    
    private func deleteDoneSupplement(deleteObject: DoneSupplements) {
        withAnimation {
            viewContext.delete(deleteObject)
            
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
    var deleteTodoSupplement: () -> Void
    
    var addDoneSupplement: () -> Void
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
                    //add Supplement to todays done supplements
                    addDoneSupplement()
                    //remove the supplement from the todoSupplement Store
                    deleteTodoSupplement()
                }label: {
                    Label("supplement taken", systemImage: "checkmark.circle")
                }
                Button(role: .destructive){
                    //only remove the supplement from todays todo store because it´s skipped today
                    deleteTodoSupplement()
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
