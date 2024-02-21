//
//  ChromiumOperation.swift
//  CommandLine
//
//  Created by YZF on 2019/12/25.
//  Copyright © 2019 Xiaoye. All rights reserved.
//

import Cocoa

class ChromiumOperation: NSObject, MyOperation {
  var options: [MyOption] = []

  override init() {
    let setupGNOption = BoolOption(
      longFlag: "gn",
      helpMessage: "ios/build/tools/setup-gn.py")

    let startGomaOption = BoolOption(
      longFlag: "goma",
      helpMessage: "goma_ctl ensure_start")

    let openXcodeOption = BoolOption(
      shortFlag: "o",
      longFlag: "xcode",
      helpMessage: "open Xcode")

    let buildOption = BoolOption(
      shortFlag: "b",
      longFlag: "build",
      helpMessage: "Build chrome for simulator with 'autoninja chrome'")

    let profileOption = BoolOption(
      shortFlag: "i",
      longFlag: "profile",
      helpMessage: "Profile chrome for iPhone device with 'autoninja chrome'")

    let buildAllOption = BoolOption(
      longFlag: "ba",
      helpMessage: "Build chrome for simulator with 'autoninja all'")

    let buildIPhoneOption = BoolOption(
      longFlag: "bi",
      helpMessage: "Build chrome for iphone with 'autoninja chrome'")

    let gclientSyncOption = BoolOption(
      shortFlag: "g",
      longFlag: "gs",
      helpMessage: "gclient sync -D -f --verbose")

    let runEdgeOption = BoolOption(
      longFlag: "run",
      helpMessage: "1.gclient sync \n      2.autoninja chrome")

    let runEdgeAllOption = BoolOption(
      longFlag: "run-all",
      helpMessage: "1.gclient sync \n      2.setup gn \n      3.autoninja chrome")

    options.append(MyOption(option: setupGNOption, sel: #selector(setupGN)))
    options.append(MyOption(option: startGomaOption, sel: #selector(startGoma)))
    options.append(MyOption(option: openXcodeOption, sel: #selector(openXcode)))
    options.append(MyOption(option: buildOption, sel: #selector(buildChrome)))
    options.append(MyOption(option: profileOption, sel: #selector(profileChrome)))
    options.append(MyOption(option: buildAllOption, sel: #selector(buildAllChrome)))
    options.append(MyOption(option: buildIPhoneOption, sel: #selector(buildIPhoneChrome)))
    options.append(MyOption(option: gclientSyncOption, sel: #selector(gclientSync)))
    options.append(MyOption(option: runEdgeOption, sel: #selector(runEdge)))
    options.append(MyOption(option: runEdgeAllOption, sel: #selector(runEdgeAll)))
  }

  @objc func setupGN() {
    let process = Process()
    process.launchPath = "/bin/zsh"

    let cmd = """
      ios/build/tools/setup-gn.py
      """

    process.arguments = ["-c", cmd]
    process.launch()
    process.waitUntilExit()
  }

  @objc func startGoma() {
    let process = Process()
    process.launchPath = "/bin/zsh"

    let cmd = """
      goma_ctl ensure_start
      """

    process.arguments = ["-c", cmd]
    process.launch()
    process.waitUntilExit()
  }

  @objc func openXcode() {
    let process = Process()
    process.launchPath = "/bin/zsh"

    let cmd = """
      open out/build/all.xcodeproj
      """

    process.arguments = ["-c", cmd]
    process.launch()
    process.waitUntilExit()
  }

  @objc func buildChrome() {
    let process = Process()
    process.launchPath = "/bin/zsh"

    let cmd = """
      cd out/Debug-iphonesimulator
      autoninja chrome -k 100
      """
    process.arguments = ["-c", cmd]
    process.launch()
    process.waitUntilExit()
  }

  @objc func profileChrome() {
    let process = Process()
    process.launchPath = "/bin/zsh"

    let cmd = """
      cd out/Profile-iphoneos
      autoninja chrome -k 100
      """
    process.arguments = ["-c", cmd]
    process.launch()
    process.waitUntilExit()
  }

  @objc func buildAllChrome() {
    let process = Process()
    process.launchPath = "/bin/zsh"

    let cmd = """
      cd out/Debug-iphonesimulator
      autoninja all -k 100
      """
    process.arguments = ["-c", cmd]
    process.launch()
    process.waitUntilExit()
  }

  @objc func buildIPhoneChrome() {
    let process = Process()
    process.launchPath = "/bin/zsh"

    let cmd = """
      cd out/Debug-iphoneos
      autoninja chrome -k 100
      """
    process.arguments = ["-c", cmd]
    process.launch()
    process.waitUntilExit()
  }

  @objc func gclientSync() {
    let process = Process()
    process.launchPath = "/bin/zsh"

    let cmd = """
      gclient sync -D -f --verbose
      """
    process.arguments = ["-c", cmd]
    process.launch()
    process.waitUntilExit()
  }

  @objc func runEdge() {
    let process = Process()
    process.launchPath = "/bin/zsh"

    let cmd = """
      yzf --gs
      yzf -b
      """
    process.arguments = ["-c", cmd]
    process.launch()
    process.waitUntilExit()
  }

  @objc func runEdgeAll() {
    let process = Process()
    process.launchPath = "/bin/zsh"

    let cmd = """
      yzf --gs
      yzf --gn
      yzf -b
      """
    process.arguments = ["-c", cmd]
    process.launch()
    process.waitUntilExit()
  }
}
