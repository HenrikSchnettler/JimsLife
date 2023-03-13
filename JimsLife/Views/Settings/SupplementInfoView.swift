//
//  SupplementInfoView.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 19.02.23.
//

import SwiftUI
import Combine
import CoreData

struct SupplementInfoView: View {
    let context: NSManagedObjectContext
    let supplement: Supplements
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false, content: {
                
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "info.circle")
                                .foregroundColor(Color.themeForegroundSecondary)
                                .frame(minWidth: 25, maxWidth: 30, minHeight: 25, maxHeight: 30)
                                .fixedSize(horizontal: true, vertical: true)
                            Text("description:")
                                .foregroundColor(Color.themeForegroundSecondary)
                                .textCase(.uppercase)
                                .bold()
                        }
                        .padding(.horizontal)
                        VStack(alignment: .leading){
                            VStack(){
                                Text(supplement.itemDescription ?? "")
                                Spacer()
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity,maxHeight: 130)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "scalemass")
                                .foregroundColor(Color.themeForegroundSecondary)
                                .frame(minWidth: 25, maxWidth: 30, minHeight: 25, maxHeight: 30)
                                .fixedSize(horizontal: true, vertical: true)
                            Text("pros & cons:")
                                .foregroundColor(Color.themeForegroundSecondary)
                                .textCase(.uppercase)
                                .bold()
                        }
                        .padding(.horizontal)
                        VStack(alignment: .center){
                            HStack(alignment: .top){
                                Text("😀")
                                    .font(.title3)
                            }
                            .padding()
                            HStack{
                                VStack{
                                    ForEach(supplement.pros ?? [], id: \.self) {itemString in
                                        HStack{
                                            Image(systemName: "plus.circle")
                                                .foregroundColor(Color.green)
                                            
                                            Text(itemString)
                                        }
                                    }
                                }
                                Divider()
                                VStack{
                                    ForEach(supplement.cons ?? [], id: \.self) {itemString in
                                        HStack{
                                            Image(systemName: "minus.circle")
                                                .foregroundColor(Color.red)
                                            
                                            Text(itemString)
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }
                        .frame(maxWidth: .infinity,maxHeight: 160)
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                    Spacer()
            })
            .navigationTitle(
                supplement.name!
            )
        }
    }
}

struct SupplementInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SupplementInfoView(context: NSManagedObjectContext(), supplement: Supplements())
    }
}
