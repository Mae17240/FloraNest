//
//  KeychainHelper.swift
//  FloraNest App
//
//  Created by Joshua Mae on 27/04/2025.
//



import Foundation
import Security
// keychian helper manages data stored within the keychain.
struct KeychainHelper {
    static func save(key: String, value: String) {
        if let data = value.data(using: .utf8) {
            let query = [
                kSecClass: kSecClassGenericPassword,
                // account identifier
                kSecAttrAccount: key,
                kSecValueData: data
            ] as CFDictionary
            SecItemDelete(query)
            // delete if there are any of the same
            SecItemAdd(query, nil)
        }
    }
    // loading from the keychain
    static func load(key: String) -> String? {
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef) // get the item back
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8) // convering the data back to string
        }
        return nil
    }
}
