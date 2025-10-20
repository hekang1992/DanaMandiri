//
//  ContactManager.swift
//  DanaMandiri
//
//  Created by Ethan Johnson on 2025/10/16.
//

import UIKit
import ContactsUI

class ContactManager: NSObject {
    
    static let shared = ContactManager()
    private let contactStore = CNContactStore()
    
    // MARK: - 权限检查与请求
    private func checkContactAuthorization(completion: @escaping (Bool) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { granted, _ in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .denied, .restricted, .limited:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
    
    private func showPermissionAlert(on vc: UIViewController) {
        let alert = UIAlertController(
            title: LanguageManager.localizedString(for: "Contacts permission is not enabled"),
            message: LanguageManager.localizedString(for: "Please go to Settings and enable contacts access to continue using this feature"),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: LanguageManager.localizedString(for: "Cancel"), style: .cancel))
        alert.addAction(UIAlertAction(title: LanguageManager.localizedString(for: "Settings"), style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))
        vc.present(alert, animated: true)
    }
    
    func fetchAllContacts(on vc: UIViewController, completion: @escaping ([[String: String]]) -> Void) {
        checkContactAuthorization { [weak self] granted in
            guard let self = self else { return }
            guard granted else {
                self.showPermissionAlert(on: vc)
                return
            }
            
            let keysToFetch = [
                CNContactGivenNameKey,
                CNContactFamilyNameKey,
                CNContactPhoneNumbersKey,
                CNContactEmailAddressesKey
            ] as [CNKeyDescriptor]
            
            var results: [[String: String]] = []
            let request = CNContactFetchRequest(keysToFetch: keysToFetch)
            do {
                try self.contactStore.enumerateContacts(with: request) { contact, _ in
                    let contactDict = self.processContactToDict(contact)
                    results.append(contactDict)
                }
                completion(results)
            } catch {
                print("获取联系人失败：\(error)")
                completion([])
            }
        }
    }

    private func processContactToDict(_ contact: CNContact) -> [String: String] {
        let familyName = contact.familyName
        let givenName = contact.givenName
        let fullName = "\(givenName) \(familyName)".trimmingCharacters(in: .whitespaces)
    
        let phoneNumbers = contact.phoneNumbers.map {
            $0.value.stringValue
        }.joined(separator: ",")
        
        var contactDict: [String: String] = [:]
        contactDict["leaderad"] = phoneNumbers.isEmpty ? "" : phoneNumbers
        contactDict["pachyade"] = fullName.isEmpty ? "" : fullName
        return contactDict
    }
    
    func selectSingleContact(on vc: UIViewController, completion: @escaping (CNContact?) -> Void) {
        checkContactAuthorization { [weak self] granted in
            guard let self = self else { return }
            guard granted else {
                self.showPermissionAlert(on: vc)
                return
            }
            
            let picker = CNContactPickerViewController()
            picker.delegate = self
            self.singleSelectCompletion = completion
            vc.present(picker, animated: true)
        }
    }
    
    private var singleSelectCompletion: ((CNContact?) -> Void)?
}

extension ContactManager: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        singleSelectCompletion?(contact)
        singleSelectCompletion = nil
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        singleSelectCompletion?(nil)
        singleSelectCompletion = nil
    }
}
