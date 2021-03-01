//
//  Settings.swift
//  TVNews
//
//  Created by SpringML_IOS on 01/03/21.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        Text("Set")
        
        Text("Language:")
        Text("English")
        Text("Later, use filters to change your language.")
        
        Text("Country:")
        Text("United States")
        Text("Only sets your place for notifications.")
        
        Text("Notifications")
        Text("Receive news updates")
        
        Text("SAVE")
        
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
