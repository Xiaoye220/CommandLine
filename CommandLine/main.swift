//
//  main.swift
//  CommandLine
//
//  Created by YZF on 2019/7/10.
//  Copyright © 2019 Xiaoye. All rights reserved.
//

import Foundation

let cli = CommandLine()

cli.formatOutput = { s, type in
    var str: String
    switch(type) {
    case .error:
        str = s.red.bold
    case .optionFlag:
        str = s.green.underline
    case .optionHelp:
        str = s.blue
    default:
        str = s
    }

    return cli.defaultFormat(s: str, type: type)
}

let help = BoolOption(shortFlag: "h", longFlag: "help",
                      helpMessage: "-h --help，帮助信息")

let git_add_tag = StringOption(longFlag: "git_add_tag",
                               helpMessage: "--git_add_tag [tag]，给 git 添加 tag，已存在则删除原有的再次添加")


cli.addOptions(help)
cli.addOptions(git_add_tag)

do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

if Swift.CommandLine.arguments.count == 1 || help.value {
    cli.printUsage()
    exit(EX_OK)
}


/* Git Operation */
if let value = git_add_tag.value {
    GitOperation.addTag(value)
}
