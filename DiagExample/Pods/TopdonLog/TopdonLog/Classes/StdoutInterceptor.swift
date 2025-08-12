//
//  StdoutInterceptor.swift
//  TopdonLog
//
//  Created by xinwenliu on 2024/8/13.
//

import Foundation

public struct OutputInterceptorOptions: OptionSet {
    
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let none = OutputInterceptorOptions(rawValue: 1 << 0)
    public static let all = OutputInterceptorOptions(rawValue: 1 << 1)
    
}

class OutputInterceptor {
   
    static var identifier: String = "[StdOut]"
    
    private var originalStdout: Int32 = -1
    private var originalStderr: Int32 = -1
    private var stdoutPipe: Pipe?
    private var stderrPipe: Pipe?
    
    func startCapturing() {
        // Create pipes
        stdoutPipe = Pipe()
        stderrPipe = Pipe()
        
        // Save original file descriptors
        originalStdout = dup(STDOUT_FILENO)
        originalStderr = dup(STDERR_FILENO)
        
        // Redirect stdout and stderr to pipes
        dup2(stdoutPipe!.fileHandleForWriting.fileDescriptor, STDOUT_FILENO)
        dup2(stderrPipe!.fileHandleForWriting.fileDescriptor, STDERR_FILENO)
        
        // Start reading output from the pipes asynchronously
        captureOutput(from: stdoutPipe!.fileHandleForReading)
        captureOutput(from: stderrPipe!.fileHandleForReading)
    }
    
    func stopCapturing() {
        // Restore original file descriptors
        if originalStdout != -1 {
            dup2(originalStdout, STDOUT_FILENO)
            close(originalStdout)
        }
        if originalStderr != -1 {
            dup2(originalStderr, STDERR_FILENO)
            close(originalStderr)
        }
        
        // Close pipes
        stdoutPipe = nil
        stderrPipe = nil
    }
    
    private func captureOutput(from fileHandle: FileHandle) {
        fileHandle.readabilityHandler = { [weak self] handle in
            guard self != nil else { return }
            let data = handle.availableData
            if let output = String(data: data, encoding: .utf8) {
                TopdonLog.info("\(output)", file: "", function: "", line: 0, Self.identifier)
            }
        }
    }
}
