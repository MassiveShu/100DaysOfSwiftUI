//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Max Shu on 18.08.2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
