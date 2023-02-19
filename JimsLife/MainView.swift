//
//  ContentView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 07.04.21.
//

import SwiftUI
import Combine
import Dispatch

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
    
    @Environment(\.managedObjectContext) private var viewContext
    
    //Todo supplements are fetched
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoSupplements.id, ascending: true)],
        animation: .easeIn)
    private var todoSupplementItems: FetchedResults<TodoSupplements>
    
    //Done supplements are fetched
    @FetchRequest(fetchRequest: DoneSupplements.fetchAllDoneSupplements)
    private var doneSupplementItems: FetchedResults<DoneSupplements>
    
    //Skipped supplements are fetched
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \SkippedSupplements.created_on, ascending: true)],
        animation: .easeIn)
    private var skippedSupplementItems: FetchedResults<SkippedSupplements>
    
    //linked supplements are fetched
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \LinkedSupplements.id, ascending: true)],
        animation: .easeIn)
    private var linkedSupplementItems: FetchedResults<LinkedSupplements>
    
    //supplements are fetched
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Supplements.itemDescription, ascending: false)],
        animation: .easeIn)
    private var supplementItems: FetchedResults<Supplements>
    
    private func manageSupplementStores(){
        //Get all supplements from the public CloudKit database
        Supplements.fetchDataFromCloudKit { (records) in
            if let records = records {
                for item in records{
                    //check if supplement with this id already exists in the users private store
                    if(Supplements.recordExists(supplementId: item.value(forKey: "CD_id") as! String, from: viewContext))
                    {
                        //check if the record in the users private database is up to date or outdated
                        
                    }
                    else{
                        //record is added to coredata and the users private database
                        Supplements.createObjectWithRecord(record: item, from: viewContext)
                    }
                }
            } else {
              print("Error fetching data from CloudKit")
            }
          }
        //todo supplements which are expired are removed from the store
        for item in todoSupplementItems{
            
            if(item.expires! <= Date.now)
            {
                TodoSupplements.removeObject(object: item, from: viewContext)
            }
        }
        
        //done supplements which are expired are removed from the store
        for item in doneSupplementItems{
            if(item.expires! <= Date.now)
            {
                DoneSupplements.removeObject(object: item, from: viewContext)
            }
        }
        
        //skipped supplements which are expired are removed from the store
        for item in skippedSupplementItems{
            if(item.expires! <= Date.now)
            {
                SkippedSupplements.removeObject(object: item, from: viewContext)
            }
        }
        
        //loop over linkedSupplements to check if there is an object of it in todoSupplements or doneSupplements or skippedsupplements
        for item in linkedSupplementItems{
            
            if(!TodoSupplements.containsSupplement(object: item.supplements!, from: viewContext) && !DoneSupplements.containsSupplement(object: item.supplements!, from: viewContext) &&
               !SkippedSupplements.containsSupplement(object: item.supplements!, from: viewContext))
            {
                //if there doesnt exists the linkedSupplement in Todo or done the there must be created a new one in todo
                TodoSupplements.addObject(objectToAdd: item, from: viewContext)
            }
        }
    }
    
    private func scheduleTaskForStartOfNextDay() {
        let calendar = Calendar.current
        let currentDate = Date()
        let nextDate = Date.now.startOfNextDay
        let timeDifference = nextDate.timeIntervalSinceNow
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeDifference) {
            //supplement stores should be synced at the beginning of every day
            manageSupplementStores()
        }
    }
    
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
                    .onAppear(){
                        //if home view is shown the supplement stores should be synchronized
                        manageSupplementStores()
                    }
                
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
        .onAppear(){
            //called on app start
            scheduleTaskForStartOfNextDay()
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
                                    NavigationLink(destination: SettingsView().onDisappear(){
                                        //if home view is shown the supplement stores should be synchronized
                                        manageSupplementStores()
                                    })
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
