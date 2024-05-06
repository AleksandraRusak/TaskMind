//
//  Extentions.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-02.
//

import Foundation

// This code adds a method to Encodable types that converts them into dictionaries by first turning them into JSON and then converting that JSON into a dictionary.

extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
