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
        let addTagOption = StringOption(shortFlag: "a",
                                        longFlag: "add_tag",
                                        helpMessage: "--git_add_tag [tag]，给 git 添加 tag，已存在则删除原有的再次添加")

        let msFormatOption = BoolOption(shortFlag: "f",
                                        longFlag: "format",
                                        helpMessage: "git ms format --upstream=origin/main")

        let rebaseMasterOption = BoolOption(shortFlag: "r",
                                            longFlag: "rebase",
                                            helpMessage: "rebase to main")
      
        let pushOption = BoolOption(shortFlag: "p",
                                    longFlag: "push",
                                    helpMessage: "push to origin")

        options.append(MyOption(option: addTagOption, sel: #selector(addTag(_:))))
        options.append(MyOption(option: msFormatOption, sel: #selector(msFormat)))
        options.append(MyOption(option: rebaseMasterOption, sel: #selector(rebaseMaster)))
        options.append(MyOption(option: pushOption, sel: #selector(push)))
    }
    
    @objc func addTag(_ tag: String) {
        let process = Process()
        process.launchPath = "/bin/zsh"
        
        let cmd = """
        export LANGUAGE=en_US.UTF-8

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

    @objc func msFormat() {
        let process = Process()
        process.launchPath = "/bin/zsh"

        let cmd = """
        export LANGUAGE=en_US.UTF-8
        git ms format --upstream=origin/main
        """

        process.arguments = ["-c", cmd]
        process.launch()
        process.waitUntilExit()
    }

    @objc func rebaseMaster() {
        let process = Process()
        process.launchPath = "/bin/zsh"

        let cmd = """
        export LANGUAGE=en_US.UTF-8
        git fetch -p
        git branch -f main origin/main
        git rebase main
        """

        process.arguments = ["-c", cmd]
        process.launch()
        process.waitUntilExit()
    }
  
    @objc func push() {
        let process = Process()
        process.launchPath = "/bin/zsh"

        let cmd = """
        export LANGUAGE=en_US.UTF-8
        git ms format --upstream=origin/main
        git add -A
        git commit --amend
        git push -f
        """

        process.arguments = ["-c", cmd]
        process.launch()
        process.waitUntilExit()
    }
}
