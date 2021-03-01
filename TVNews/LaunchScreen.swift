//
//  LaunchScreen.swift
//  TVNews
//
//  Created by SpringML_IOS on 01/03/21.
//

import SwiftUI

struct LaunchScreen: View {
    @StateObject private var model = DataCountProvider()
    var body: some View {
        Text("Loading...")
        if let cCount = model.dtCount.channelCount{
            Text("\(String(describing: cCount))" + " Channels").padding(10)
        }
        if let cCount = model.dtCount.channelCount{
            Text("\(String(describing: cCount))" + " Countries").padding(5)
        }
        if let cCount = model.dtCount.channelCount{
            Text("\(String(describing: cCount))" + " Languages").padding(5)
        }
        
        Text("Ads Help").padding(Edge.Set(rawValue: 100),10)
        Text("Look for (X) to CLOSE full screen ads that do NOT intrest you. Avoid accidental ad clicks.")
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
