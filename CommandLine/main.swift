//
//  main.swift
//  CommandLine
//
//  Created by YZF on 2019/7/10.
//  Copyright © 2019 Xiaoye. All rights reserved.
//

import Foundation

print("Hello, World!")



let p = Process()
p.launchPath = "/bin/bash"
let cmd = "echo '输入路径:'"
p.arguments = ["-c", cmd]
p.launch()

let keyboard = FileHandle.standardInput
let inputData = keyboard.availableData
var strData = String(data: inputData, encoding: String.Encoding.utf8)!
strData.removeLast()


let p2 = Process()
p2.launchPath = "/bin/bash"
let cmd2 = "path=\(strData);dir=${path%/*};file=${path##*/};echo $dir;echo $file"

print(cmd2)

p2.arguments = ["-c", cmd2]
p2.launch()
