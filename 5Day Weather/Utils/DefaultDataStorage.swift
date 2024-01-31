//
//  DefaultDataStorage.swift
//  5Day Weather
//
//  Created by Adel on 1/29/24.
//

import Foundation

protocol DateStorage {
    func saveDate(_ date: Date, forKey key: String)
    func retrieveDate(forKey key: String) -> Date?
}

class DefaultDataStorage: DateStorage {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func saveDate(_ date: Date, forKey key: String) {
        userDefaults.set(date, forKey: key)
    }

    func retrieveDate(forKey key: String) -> Date? {
        return userDefaults.value(forKey: key) as? Date
    }
}
