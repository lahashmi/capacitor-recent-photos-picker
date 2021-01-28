import Foundation
import Capacitor
import Photos
/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(RecentPhotosPicker)
public class RecentPhotosPicker: CAPPlugin {

        @objc func getRecentPhotos(_ call: CAPPluginCall) {

        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.fetchLimit = 10

        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)

        if(fetchResult.count > 0){
            var images = [String]()
            for _index in (0...fetchResult.count){

            let image = getAssetThumbnail(asset: fetchResult.object(at: _index))
            let imageData =  image.pngData()!
            let base64String = imageData.base64EncodedString()
            images.append(base64String)
            }

            call.success([
                "images": images
                ])

        } else {

            call.error("Could not get photos")

        }

    }

    func getAssetThumbnail(asset: PHAsset) -> UIImage {

        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()

        var thumbnail = UIImage()
        option.isSynchronous = true

        manager.requestImage(for: asset, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })

        return thumbnail
    }

}
