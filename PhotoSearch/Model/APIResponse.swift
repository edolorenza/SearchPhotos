//
//  PhotoData.swift
//  PhotoSearch
//
//  Created by Edo Lorenza on 18/05/21.
//

import Foundation

struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let full: String
    let regular: String
}
