// Run on macOS: swift export_symbols.swift names.json output-directory
import AppKit
import Foundation
let app = NSApplication.shared
let names = try JSONDecoder().decode([String].self, from: Data(contentsOf: URL(fileURLWithPath: CommandLine.arguments[1])))
let output = URL(fileURLWithPath: CommandLine.arguments[2], isDirectory: true)
try FileManager.default.createDirectory(at: output, withIntermediateDirectories: true)
let pointSize: CGFloat = 256
let scale: CGFloat = 3
let padding: CGFloat = 24
var entries: [[String: Any]] = []
for name in names {
 for (weightName, weight) in [("regular", NSFont.Weight.regular), ("medium", NSFont.Weight.medium)] {
  guard let symbol = NSImage(systemSymbolName: name, accessibilityDescription: nil)?.withSymbolConfiguration(NSImage.SymbolConfiguration(pointSize: pointSize, weight: weight)) else {
   if name == "calculator" { continue }
   fputs("Missing symbol: \(name)\n", stderr); exit(1)
  }
  symbol.isTemplate = false
  let size = symbol.size
  let width = Int(ceil(size.width * scale + padding * 2))
  let height = Int(ceil(size.height * scale + padding * 2))
  let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: width, pixelsHigh: height, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
  NSGraphicsContext.saveGraphicsState()
  NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmap)
  NSColor.white.setFill()
  NSRect(x: 0, y: 0, width: width, height: height).fill()
  symbol.draw(in: NSRect(x: padding, y: padding, width: size.width * scale, height: size.height * scale), from: .zero, operation: .sourceOver, fraction: 1)
  NSGraphicsContext.restoreGraphicsState()
  let filename = name + "--" + weightName + ".png"
  try bitmap.representation(using: .png, properties: [:])!.write(to: output.appendingPathComponent(filename))
  entries.append(["symbol": name, "weight": weightName, "file": filename, "pointSize": pointSize, "scale": scale, "width": width, "height": height, "padding": padding])
 }
}
let manifest = try JSONSerialization.data(withJSONObject: entries, options: [.prettyPrinted, .sortedKeys])
try manifest.write(to: output.appendingPathComponent("manifest.json"))
print("Exported \(entries.count) symbol variants")
