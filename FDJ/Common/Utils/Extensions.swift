//
//  Extensions.swift
//  iTunesSearchAPI
//
//  Created by Sandy Ludosky on 22/04/2019.
//  Copyright © 2019 Sandy Ludosky. All rights reserved.
//

import Foundation
import UIKit

extension URL {
    func encode() -> URL? {
        let stringURL = self.absoluteString
        let allowedCharacterSet = (CharacterSet(charactersIn: "%").inverted)
        guard let encodedString = stringURL.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) else {
            return nil
        }
        guard let encodedURL = URL(string: encodedString) else {
            return nil
        }
        return encodedURL
    }
}

extension Sequence {
    func transform<T: Codable>(_ type: T.Type) -> Any {
        let results = try? self.map({ dict -> Any in
            guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
                throw ErrorHandler.invalidData
            }
            return try JSONDecoder().decode(T.self, from: data)
        })
        return results ?? []
    }
}

extension String {
    func format() -> String? {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+0100"
        guard let date = format.date(from: self) else { return nil }
        format.dateFormat = "MM/dd/yyyy"
        return format.string(from: date)
    }
}

