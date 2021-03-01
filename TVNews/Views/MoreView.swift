//
//  MoreView.swift
//  TVNews
//
//  Created by SpringML_IOS on 01/03/21.
//

import SwiftUI
struct Options: Hashable {
    var image = String()
    var title = String()
}
struct MoreView: View {
    let modelData: [Options] =
        [Options(image: "person.crop.circle", title: "About Us"),
         Options(image: "person.crop.circle", title: "Contact Us"),
         Options(image: "person.crop.circle", title: "Send Comments"),
         Options(image: "person.crop.circle", title: "Take Survey"),
         Options(image: "person.crop.circle", title: "Rate app - Like it? Please rate"),
         Options(image: "person.crop.circle", title: "Disclaimer"),
        ]
    var body: some View {
        VStack{
            Image(systemName: "person.crop.circle")
                .frame(width: 100, height: 100, alignment: .center)
            Text("TV News")
            ForEach((modelData), id: \.self) { weather in
                HStack {
                    Image(systemName: weather.image)
                        .frame(width: 50, height: 10, alignment: .leading)
                    Text(weather.title)
                        .frame(width: 200, height: 10, alignment: .leading)
                }.font(.body).foregroundColor(.black)
                .padding(10)
            }
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
