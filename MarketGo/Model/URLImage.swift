//
//  URLImage.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/15.
//  이부분때문에 서버에서 이미지 받아올때 느려지는거같다.

import SwiftUI
import Alamofire


struct URLImage: View {
    let url: URL?
    let placeholder: Image
    
    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholder = placeholder
    }
    
    @State private var imageData: Data?
    
    var body: some View {
        Group {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(1)
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(1)
            }
        }
        .onAppear {
            if let url = url {
                AF.request(url).responseData { response in
                    if case .success(let data) = response.result {
                        self.imageData = data
                    }
                }
            }
        }
    }
}

//struct URLImage: View {
//    let url: URL?
//    let placeholder: Image
//
//    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
//        self.url = url
//        self.placeholder = placeholder
//    }
//
//    var body: some View {
//        Group {
//            if let url = url, let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 80, height: 80)
//                    .cornerRadius(1)
//            } else {
//                placeholder
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 80, height: 80)
//                    .cornerRadius(1)
//            }
//        }
//    }
//}
