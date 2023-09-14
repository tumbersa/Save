//
//  KeychainStorage.swift
//  Save
//
//  Created by Глеб Капустин on 14.09.2023.
//

import Security
import Foundation

enum KeychainKeys: String {
    case service = "service"
    case account = "account"
}
final class KeychainStorage: StorageProtocol {
    var text: String? {
        get{
            getText()
        }
        set{
setText(newValue)
        }
    }
    init(){}
}

private extension KeychainStorage {
    func getText() -> String? {
        let query = [
            kSecAttrService: KeychainKeys.service,
            kSecAttrAccount: KeychainKeys.account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return result as? String
        return "error"
    }
    
    func setText(_ text: String?){
        let query = [
            kSecValueData: text?.data(using: .utf8) as? Any,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: KeychainKeys.service,
            kSecAttrAccount: KeychainKeys.account
        ] as CFDictionary
        let status = SecItemAdd(query, nil)
        if status != errSecSuccess {
            print("Error \(status)")
        }
//        guard let value: Data = text?.data(using: .utf8) else {return}
//        let tag: Data = "com.test.key".data(using: .utf8)!
//        let attributes: [String: Any] = [
//                String(kSecClass): kSecClassKey,
//                String(kSecAttrApplicationTag): tag,
//                String(kSecValueData): value
//            ]
//
//            var result: CFTypeRef? = nil
//            let status = SecItemAdd(attributes as CFDictionary, &result)
//            if status == errSecSuccess {
//                print("Successfully added to keychain.")
//            } else {
//                if let error: String = SecCopyErrorMessageString(status, nil) as String? {
//                    print(error)
//                }
//            }
//
    }
}
