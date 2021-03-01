//
//  TVNewsApp.swift
//  TVNews
//
//  Created by SpringML_IOS on 01/02/21.
//

import SwiftUI

@main
struct TVNewsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
