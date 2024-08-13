func printFile(_ message: String) {
    Logger.shared.log(message)
}

class Logger {
    static let shared = Logger()
    
    private init() {}
    
    private var logFileURL: URL? {
        let fileManager = FileManager.default
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            return documentsDirectory.appendingPathComponent("app.log")
        }
        return nil
    }

    func log(_ message: String) {
        guard let logFileURL = logFileURL else { return }

        let timestamp = Date().description
        let logMessage = "[\(timestamp)] \(message)\n"
        print(logMessage)

        if !FileManager.default.fileExists(atPath: logFileURL.path) {
            FileManager.default.createFile(atPath: logFileURL.path, contents: nil, attributes: nil)
        }

        if let fileHandle = try? FileHandle(forWritingTo: logFileURL) {
            fileHandle.seekToEndOfFile()
            if let data = logMessage.data(using: .utf8) {
                fileHandle.write(data)
            }
            fileHandle.closeFile()
        }
    }

    func readLog() -> String? {
        guard let logFileURL = logFileURL else { return nil }
        return try? String(contentsOf: logFileURL, encoding: .utf8)
    }
}