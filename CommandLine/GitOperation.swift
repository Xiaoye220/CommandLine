//
//  GitOperation.swift
//  CommandLine
//
//  Created by YZF on 2019/7/11.
//  Copyright © 2019 Xiaoye. All rights reserved.
//

import Foundation

struct GitOperation {
    
    static func addTag(_ tag: String) {
        let process = Process()
        process.launchPath = "/bin/bash"
        
        let cmd = """
        tag=\(tag)
        
        git pull --tags
        existTag=`git tag -l \\| grep $tag`
        
        if [ "$existTag" != "" ]
        then
        
        git tag -d $tag
        git push origin :refs/tags/$tag
        
        fi
        
        git tag -a $tag -m $tag
        git push origin --tags
        """
        
        process.arguments = ["-c", cmd]
        process.launch()
        process.waitUntilExit()
    }
    
}
