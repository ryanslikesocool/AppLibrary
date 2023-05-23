import Cocoa

let app = NSApplication.shared

let delegate = AppDelegate()
app.delegate = delegate

let menu = AppMenu()
app.menu = menu

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
