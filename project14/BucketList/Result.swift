//
//  Result.swift
//  BucketList
//
//  Created by Mykhailo Tsuber on 9/22/24.
//

import Foundation

struct Result: Codable {
  let query: Query
}

struct Query: Codable {
  let pages: [Int: Page]
}

struct Page: Codable {
  let pageid: Int
  let title: String
  let terms: [String: [String]]?
}
