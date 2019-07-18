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

extension Array where Element: Decodable {
    func transform<T: Codable>(_ type: T.Type) -> Any {
        let results = try? self.map({ dict -> Any in
            guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
                throw ErrorHandler.invalidData
            }
            return try JSONDecoder().decode(T.self, from: data)
        })
        return results ?? []
    }
    
    func filter() -> [Element] {
        let filtered = self.filter({ element -> Bool in
            return element != nil
        })
        return filtered
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

extension UICollectionView {
    func setLayout(with width: CGFloat, columns: CGFloat, margin: Int) {
        let minus = (margin * 2) + (margin / 2)
        let w = (width / columns) - CGFloat(minus)
        let cellWidth : CGFloat = w
        let cellheight : CGFloat = w
        let cellSize = CGSize(width: cellWidth , height:cellheight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical 
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1.0, left: CGFloat(margin), bottom: 1.0, right:  CGFloat(margin))
        layout.minimumLineSpacing = CGFloat(margin / 2)
        layout.minimumInteritemSpacing = 1.0
        self.setCollectionViewLayout(layout, animated: true)
    }
    
    func set(margin: Int) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 1.0, left: CGFloat(margin), bottom: 1.0, right:  CGFloat(margin))
        layout.minimumLineSpacing = CGFloat(margin / 2)
        layout.minimumInteritemSpacing = 1.0
        self.setCollectionViewLayout(layout, animated: true)
    }
}
