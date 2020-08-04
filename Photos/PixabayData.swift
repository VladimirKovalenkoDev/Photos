//
//  PixabayData.swift
//  Photos
//
//  Created by Владимир Коваленко on 03.08.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import Foundation

struct PixabayData: Codable {
    let hits : [PhotoData]
}
struct PhotoData: Codable {
    let previewURL : String
}
