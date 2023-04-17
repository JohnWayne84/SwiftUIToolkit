//
//  File.swift
//  
//
//  Created by user on 17.04.2023.
//

import Foundation
import SwiftUI


public struct RefreshableKeyTypes {
    
    enum PositionType {
        case fixed, moving
    }
    
    struct Position: Equatable {
        let type: PositionType
        let bounds: CGFloat
    }
    
    struct PrefKey: PreferenceKey {
        typealias Value = [Position]
        static var defaultValue = [Position]()
        static func reduce(value: inout [Position], nextValue: () -> [Position]) {
            value.append(contentsOf: nextValue())
        }
    }
}

public struct PositionIndicator: View {
    let type: RefreshableKeyTypes.PositionType
    public var body: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: RefreshableKeyTypes.PrefKey.self, value: [RefreshableKeyTypes.Position(type: type, bounds: proxy.frame(in: .global).minY)])
        }
    }
}
