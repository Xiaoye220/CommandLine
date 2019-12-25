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
cli.addOptions(help)


var operations: [MyOperation] = []
operations.append(GitOperation())
operations.append(ShellOperation())
operations.append(ChromiumOperation())

operations.forEach { operation in
    operation.addOptions(to: cli)
}

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
operations.forEach { operation in
    operation.performOptions()
}
