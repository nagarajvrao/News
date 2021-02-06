//
//  Optional.swift
//  News
//
//  Created by Nagaraj on 06/02/21.
//

import Foundation

extension Optional where Wrapped == String {
    var unwrap: String {
        if let value = self {
            return value
        }
        return ""
    }
}
