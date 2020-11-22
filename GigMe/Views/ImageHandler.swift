//
//  ImageHandler.swift
//  GigMe
//
//  Created by Miles Broomfield on 21/11/2020.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

struct UrlImage: View {
    
    @ObservedObject var urlImageModel:URLImageModel
    var width:CGFloat?
    var height:CGFloat?
    var contentMode:ContentMode
    var defaultImage:UIImage
    
    
    init(urlString: String?=nil,path:String?=nil,width:CGFloat?=nil, height:CGFloat?=nil, contentMode:ContentMode = .fill,def:String = "default"){
        self.width = width
        self.height = height
        self.contentMode = contentMode
        urlImageModel = URLImageModel(urlString: urlString,path: path)
        self.defaultImage = UIImage(named:def)!
    }
    
    var body: some View {
        VStack(spacing:0){
            Image(uiImage: urlImageModel.image ?? defaultImage)
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .frame(width:width,height: height)
                .clipped()
            HStack{
                Spacer()
            }
            .frame(height:0)
        }
            //.background(Rectangle().foregroundColor(Color("lightGray")))
    }
}

class URLImageModel:ObservableObject{
    
    @Published var image:UIImage?
    var urlString: String?
    var imageCache = ImageCache.getImageCache()
    
    init(urlString:String?=nil,path:String?=nil){
        if(urlString != nil){
            self.urlString = urlString
            if (self.loadImageFromCache()){
                return
            }
            else{
                loadImageFromURL()
            }
        }
        if(path != nil){
            self.urlString = path
            if (self.loadImageFromCache()){
                return
            }
            else{
                loadImageFromPath()
            }
        }
    }
    
    func loadImageFromCache() ->Bool{
        guard let urlString = urlString else{
            return false
        }
        
        guard let cacheImage = imageCache.get(forKey: urlString) else {return false}
        
        image = cacheImage
        return true
        
    }
    
    func loadImageFromURL(){
        guard let urlString = urlString else{return}
        
        guard let url = URL(string: urlString) else{ return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:respone:error:))
        task.resume()
    }
    
    func loadImageFromPath(){
        guard let urlString = urlString else{return}
        Storage.storage().reference(withPath: urlString).getData(maxSize: 20000*20000) { (data, err) in
            self.getImageFromResponse(data: data, respone: nil, error: err)
        }
    }
    
    func getImageFromResponse(data:Data?, respone:URLResponse?, error:Error?){
        guard error == nil else{
            print("Error:\(error!)")
            return
        }
        
        guard let data = data else{
            print("not data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else{
                return
            }
            self.imageCache.set(forKey: self.urlString!, image: loadedImage)
            self.image = loadedImage
        }
        
    }
    
}

class ImageCache{
    var cache = NSCache<NSString,UIImage>()
    
    func get(forKey:String) -> UIImage?{
        return cache.object(forKey: NSString(string:forKey))
    }
    
    func set(forKey:String, image: UIImage){
        cache.setObject(image, forKey: NSString(string: forKey))
    }
    
    
}

extension ImageCache{
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache{
        return imageCache
    }
}
