//
//  ThreadingView.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/16/23.
//

import SwiftUI

struct ThreadingView: View {
    @State var images:[UIImage]=[UIImage(named:ImageConstants.Test)!,UIImage(named:ImageConstants.Test)!,UIImage(named:ImageConstants.Test)!,UIImage(named:ImageConstants.Test)!]
    var queue=OperationQueue()
    let imageLoader=ImageLoader()
    var body: some View {
        VStack {
            HStack {
                Image(uiImage:images[0]).resizable().scaledToFit()
                Image(uiImage:images[1]).resizable().scaledToFit()
            }
            HStack {
                Image(uiImage: images[2]).resizable().scaledToFit()
                Image(uiImage: images[3]).resizable().scaledToFit()
            }
            
            HStack{
                Button(LabelConstants.Download){
                    downloadImageWithCache()
                }
                Spacer()
                Button(LabelConstants.Reset){
                    images=[UIImage(named:ImageConstants.Test)!,UIImage(named:ImageConstants.Test)!,UIImage(named:ImageConstants.Test)!,UIImage(named:ImageConstants.Test)!]
                }
            }.padding()
           
        }
    }
    private func download(){
//        queue.maxConcurrentOperationCount=1
        let op1=BlockOperation {
            let image = Downloader().downloadImageFromURL(imageURLStrings[0])
            OperationQueue.main.addOperation {
                images[0]=image
            }
        }
        let op2=BlockOperation {
            let image = Downloader().downloadImageFromURL(imageURLStrings[1])
            OperationQueue.main.addOperation {
                images[1]=image
            }
        }
        let op3=BlockOperation {
            let image = Downloader().downloadImageFromURL(imageURLStrings[2])
            OperationQueue.main.addOperation {
                images[2]=image
            }
        }
        let op4=BlockOperation {
            let image = Downloader().downloadImageFromURL(imageURLStrings[3])
            OperationQueue.main.addOperation {
                images[3]=image
            }
        }
        queue.addOperation(op1)
//        op2.addDependency(op1) // Add Dependance for threads
        queue.addOperation(op2)
        queue.addOperation(op3)
        queue.addOperation(op4)
    }
    private func downloadImageWithCache(){
        for i in 0...3{
            imageLoader.downloadImageFrom(imageURLStrings[i]) { UIImage in
                images[i] = UIImage
            }
        }
        
    }
}

#Preview {
    ThreadingView()
}
let imageURLStrings=["https://www.planetware.com/wpimages/2023/09/california-los-angeles-melrose-avenue-scout.jpg","https://www.planetware.com/wpimages/2023/09/california-los-angeles-melrose-avenue-wasteland.jpg","https://www.planetware.com/wpimages/2023/09/california-los-angeles-melrose-avenue-american-vintage-store.jpg","https://www.planetware.com/wpimages/2023/09/california-los-angeles-melrose-avenue-world-of-vintage.jpg"]
class Downloader{
    func downloadImageFromURL(_ imageURLString:String) -> UIImage{
        //Avoid Force Unboxing
        if let imageData = try? Data(contentsOf: URL(string: imageURLString)!){
            return UIImage(data: imageData)!
        }
        return UIImage(named: ImageConstants.Test)!
    }
}
