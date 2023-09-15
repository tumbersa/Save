////
////  KeychainStorage.swift
////  Save
////
////  Created by Глеб Капустин on 14.09.2023.
////
//
//import Security
//import Foundation
//
//enum KeychainKeys: String {
//    case service = "service"
//    case account = "account"
//}
//final class KeychainStorage: StorageProtocol {
//    var text: String? {
//        get{
//            getText()
//        }
//        set{
//            setText(newValue)
//        }
//    }
//    init(){}
//}
//
//private extension KeychainStorage {
//
//    func getText() -> String? {
//        let tag: Data = "com.test.key".data(using: .utf8)!
//        let query = [
//            kSecAttrApplicationTag: tag,
//            kSecClass: kSecClassKey,
//            kSecReturnData: true
//        ] as CFDictionary
//
//        var result: CFTypeRef?
//        SecItemCopyMatching(query, &result)
//        return result as? String
//        return "error"
//    }
//
//    func setText(_ text: String?){
////        let query = [
////            kSecValueData: text?.data(using: .utf8) as? Any,
////            kSecClass: kSecClassGenericPassword,
////            kSecAttrService: KeychainKeys.service,
////            kSecAttrAccount: KeychainKeys.account
////        ] as CFDictionary
////        let status = SecItemAdd(query, nil)
////        if status != errSecSuccess {
////            print("Error \(status)")
////        }
//
//        guard let value = text?.data(using: .utf8)  else {return}
//        let tag: Data = "com.test.key".data(using: .utf8)!
//        removeFromKeychain(value, tag: tag)
//        let attributes = [
//                kSecClass: kSecClassKey,
//                kSecAttrApplicationTag: tag,
//                kSecValueData: value
//            ] as CFDictionary
//
//            var result: CFTypeRef? = nil
//            let status = SecItemAdd(attributes, &result)
//            if status == errSecSuccess {
//                print("Successfully added to keychain.")
//            } else {
//                if let error: String = SecCopyErrorMessageString(status, nil) as String? {
//                    print(error)
//                }
//            }
//
//    }
//}
//func removeFromKeychain(_ value: Data, tag: Data) {
//    let attributes: [String: Any] = [
//        String(kSecClass): kSecClassKey,
//        String(kSecAttrApplicationTag): tag,
//        String(kSecValueData): value
//    ]
//
//    let status = SecItemDelete(attributes as CFDictionary)
//    if status == errSecSuccess {
//        print("Successfully removed from keychain.")
//    } else {
//        if let error: String = SecCopyErrorMessageString(status, nil) as String? {
//            print(error)
//        }
//
//    }
//}
import Security
import UIKit

final class KeychainStorage: StorageProtocol {

    let key = "Some Key"
    var text: String? {
        get{
            if let data = load(key: key) {
                let result = String(decoding: data, as: UTF8.self)
                return result
            }
            return nil
        }
            set{
                guard let data = newValue?.data(using: .utf8) else {return}
                let status = save(key: key, data: data)
                print("status: \(status)")
            }
     }
        
    
    func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data
        ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }

    func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }

//    func createUniqueID() -> String {
//        let uuid: CFUUID = CFUUIDCreate(nil)
//        let cfStr: CFString = CFUUIDCreateString(nil, uuid)
//
//        let swiftString: String = cfStr as String
//        return swiftString
//    }
}

//extension Data {
//
//    init<T>(from value: T) {
//        var value = value
//        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
//    }
//
//    func to<T>(type: T.Type) -> T {
//        return self.withUnsafeBytes { $0.load(as: T.self) }
//    }
//}
