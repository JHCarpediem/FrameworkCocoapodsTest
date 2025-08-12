//
//  AVFoundation+TDExtension.swift
//  LMSUI
//
//  Created by fench on 2023/12/20.
//

import Photos
import AVFoundation

public extension TDBasisWrap where Base: AVURLAsset {
    
    public var fileSize: UInt64? {
        let assetURL = base.url
        do {
            let resourceValues = try assetURL.resourceValues(forKeys: [URLResourceKey.fileSizeKey])
            if let fileSize = resourceValues.fileSize {
                return UInt64(fileSize)
            } else {
                return nil
            }
        } catch {
            print("Error retrieving file size: \(error)")
            return nil
        }
    }
}


public extension TDBasisWrap where Base: PHAsset {
    public func getAVAssetFromPHAsset(completion: @escaping (_ asset: AVAsset?) -> Void) {
        let videoOptions = PHVideoRequestOptions()
        videoOptions.version = .original

        PHImageManager.default().requestAVAsset(forVideo: base, options: videoOptions) { avAsset, _, _ in
            completion(avAsset)
        }
    }
    
    public func getPlayerItemFromPHAsset(completion: @escaping (_ playerItem: AVPlayerItem?) -> Void) {
        let videoOptions = PHVideoRequestOptions()
        videoOptions.version = .original

        PHImageManager.default().requestPlayerItem(forVideo: base, options: videoOptions, resultHandler: { playerItem, _ in
            completion(playerItem)
        })
    }
}
