//
//  UserDefaultsStorage.swift
//  Save
//
//  Created by Глеб Капустин on 14.09.2023.
//

import Foundation

enum StorageKeys: String {
    case storageKey
}

final class UserDefaultsStorage: StorageProtocol {
    private let storage = UserDefaults.standard
    
    
    
    var text: String? {
        get{
            storage.string(forKey: StorageKeys.storageKey.rawValue)
        }
        set{
            storage.set(newValue, forKey: StorageKeys.storageKey.rawValue)
        }
    }
    
}
