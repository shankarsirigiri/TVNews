//
//  ContentView.swift
//  TVNews
//
//  Created by SpringML_IOS on 01/02/21.
//

import SwiftUI
import CoreData

struct CircleView: View {
    @State var label: String
    @State var chProvider: ChannelsProvider
    @Binding var currentStage: String
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .frame(width: 100, height: 40)
            Text(label).onTapGesture {
                self.currentStage = label
                if label == "Top"{
                    self.chProvider.fetchChannels(type: .top)
                }else if label == "Demand"{
                    self.chProvider.fetchChannels(type: .demand)
                }else if label == "Live" {
                    self.chProvider.fetchChannels(type: .live)
                }else if label == "Popular"{
                    self.chProvider.fetchChannels(type: .popular)
                }else if label == "More"{
                   
                }
            }
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    private var gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    private var menuItems = ["Favorites", "Your Mix", "Your Live", "Stories", "Top", "Demand", "Live", "Popular", "More"]
    @StateObject private var model = ChannelsProvider()
    
    @State var currentStage = "Favorites"
    
    var body: some View {
        
        NavigationView {
            VStack{
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(menuItems, id: \.self) { title in
                            CircleView(label: title, chProvider: model, currentStage: $currentStage)
                        }
                    }.padding()
                }.frame(height: 40)
                ScrollView{
                    if currentStage == "More"{
                        MoreView()
                    }else if currentStage == "Top" || currentStage == "Popular"{
                        LazyVGrid(columns: gridItems, spacing: 10) {
                            ForEach((model.channels), id: \.self) { item in
                                ImageViewCache(urls: (urlString: item.thumb, lowResURLString: item.thumb), errorImage: UIImage(systemName: "pause.rectangle.fill"), item: item)
                                    .onTapGesture {
                                        print(item.title ?? "")
                                    }
                            }
                            .padding(10)
                        }
                    }else if currentStage == "Live" || currentStage == "Demand"{
                        LazyVStack{
                            ForEach((model.channels), id: \.self) { item in
                                ImageViewCache(urls: (urlString: item.thumb, lowResURLString: item.thumb), errorImage: UIImage(systemName: "pause.rectangle.fill"), item: item)
                                    .onTapGesture {
                                        print(item.title ?? "")
                                    }
                            }
                            .padding(10)
                        }
                    }
                    else if currentStage == "Stories"{
                        Stories()
                    }else if currentStage == "Your Mix"{
                        YourMix()
                    }else if currentStage == "Your Live"{
                        YourLive()
                    }else if currentStage == "Favorites"{
                        Favorites()
                    }
                    
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Image(systemName: "sun.min.fill")
                        Text("TV News").font(.headline)
                    }
                }
            }
            .navigationBarItems(trailing:
                                    HStack {
                                        Button(action: {
                                            print("Reload button pressed...")
                                        }) {
                                            //Text("Reload")
                                            Image(systemName: "person.crop.circle").imageScale(.large)
                                        }
                                        
                                        Button(action: {
                                            print("Edit button pressed...")
                                        }) {
                                            Image(systemName: "person.crop.circle").imageScale(.large)
                                        }
                                        
                                        Button(action: {
                                            print("Settings button pressed...")
                                        }) {
                                            Image(systemName: "person.crop.circle").imageScale(.large)
                                        }
                                    }
            )
        }
    }
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
            animation: .default)
        private var items: FetchedResults<Item>
        
        private func addItem() {
            withAnimation {
                let newItem = Item(context: viewContext)
                newItem.timestamp = Date()
                
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
        
        private func deleteItems(offsets: IndexSet) {
            withAnimation {
                offsets.map { items[$0] }.forEach(viewContext.delete)
                
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
