//
//  GitOperation.swift
//  CommandLine
//
//  Created by YZF on 2019/7/11.
//  Copyright © 2019 Xiaoye. All rights reserved.
//

import Foundation

class GitOperation: NSObject, MyOperation {
    
    public var options: [MyOption] = []
    
    override init() {
        let addTag = StringOption(shortFlag: "a",
                                  longFlag: "git_add_tag",
                                  helpMessage: "--git_add_tag [tag]，给 git 添加 tag，已存在则删除原有的再次添加")
        
        options.append(MyOption(option: addTag, sel: #selector(addTag(_:))))
    }
    
    @objc func addTag(_ tag: String) {
        let process = Process()
        process.launchPath = "/bin/bash"
        
        let cmd = """
        tag=\(tag)
        
        git pull --tags
        existTag=$(git tag -l | grep $tag)
        
        if [ "${existTag}" != "" ]
        then
        
        git tag -d ${tag}
        git push origin :refs/tags/${tag}
        
        fi
        
        git tag -a ${tag} -m ${tag}
        git push origin --tags
        """
        
        process.arguments = ["-c", cmd]
        process.launch()
        process.waitUntilExit()
    }
    
}
