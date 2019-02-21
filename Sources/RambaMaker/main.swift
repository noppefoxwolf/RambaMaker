import Foundation
import xcodeproj
import PathKit
import Corazza
import Stencil
import Commander

let main = command(Argument<String>("path", description: "xcworkspace filepath")) { (filePath: String) in
  let xcworkspacePath = Path(filePath)
  guard xcworkspacePath.extension == "xcworkspace" else { print("Path is not xcworkspace."); exit(0) }
  let path = xcworkspacePath.parent()
  
  let xcworkspace = try XCWorkspace(path: xcworkspacePath)
  
  let projectLocations = xcworkspace.data.children.reduce(into: [String](), { (result, element) in
    switch element {
    case .group(_): break
    case let .file(file):
      result.append(file.location.path)
    }
  })
  
  let prompt = Prompt()
  guard let targetLoaction = prompt.options(projectLocations, question: "Choose xcodeproj") else {
    print("Should select xcodeproj")
    exit(0)
  }
  
  guard let targetName = targetLoaction.components(separatedBy: "/").last?.replacingOccurrences(of: ".xcodeproj", with: "") else { fatalError() }
  
  let context = [
    "xcodeproj_path": targetLoaction,
    "project_target" : targetName,
    ]
  
  let environment = Environment(loader: FileSystemLoader(paths: [path]))
  let rendered = try environment.renderTemplate(name: "Rambafile.stencil", context: context)
  
  let url = URL(fileURLWithPath: path.string + "/Rambafile")
  try rendered.write(to: url, atomically: true, encoding: .utf8)
}

main.run()



