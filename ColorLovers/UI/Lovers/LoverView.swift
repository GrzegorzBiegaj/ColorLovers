//
//  LoverView.swift
//  ColorLovers
//
//  Created by Grzesiek on 05/03/2023.
//

import SwiftUI

struct LoverView: View {
    var name: String
    var details: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(verbatim: name)
                .font(.system(size: 16))
            Text(verbatim: details)
                .font(.system(size: 11))
                .foregroundColor(.gray)
        }
    }
}

struct LoverView_Previews: PreviewProvider {
    static var previews: some View {
        LoverView(name: "name", details: "details")
    }
}
