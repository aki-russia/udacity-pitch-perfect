//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Dmitriy Kharchenko on 3/30/15.
//  Copyright (c) 2015 Dmitriy Kharchenko. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(url:NSURL) {
        filePathUrl = url
        title = url.lastPathComponent
        
    }
}