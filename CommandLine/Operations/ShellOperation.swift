//
//  ShellOperation.swift
//  CommandLine
//
//  Created by YZF on 2019/8/9.
//  Copyright © 2019 Xiaoye. All rights reserved.
//

import Foundation

class ShellOperation: NSObject, MyOperation {

  public var options: [MyOption] = []

  override init() {
    let chmodOption = BoolOption(
      longFlag: "chmod",
      helpMessage: "修改文件权限为可访问")
    options.append(MyOption(option: chmodOption, sel: #selector(chmod)))

    let srcOption = BoolOption(
      shortFlag: "s",
      longFlag: "src",
      helpMessage: "cd to anaheim src")
    options.append(MyOption(option: srcOption, sel: #selector(cdSrc)))
  }

  @objc func chmod() {
    print("输入文件路径:")
    // 读取用户输入的值
    let keyboard = FileHandle.standardInput
    let inputData = keyboard.availableData
    var strData = String(data: inputData, encoding: String.Encoding.utf8)!
    // 删除最后的换行符
    strData.removeLast()

    let process = Process()
    process.launchPath = "/bin/zsh"

    let cmd = """
      path=\(strData)

      dir=${path%/*}
      file=${path##*/}

      cd $dir

      chmod 777 "./"$file
      """

    process.arguments = ["-c", cmd]
    process.launch()
    process.waitUntilExit()
  }

  @objc func cdSrc() {
    let process = Process()
    process.launchPath = "/bin/zsh"

    let cmd = """
      cd ~/Desktop/anaheim/src
      """

    process.arguments = ["-c", cmd]
    process.launch()
    process.waitUntilExit()
  }
}
