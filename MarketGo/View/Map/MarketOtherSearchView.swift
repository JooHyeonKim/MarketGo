//
//  MarketOtherSearchView.swift
//  MarketGo
//
//  Created by ram on 2023/05/30.
//

import SwiftUI
import UIKit

struct MarketOtherSearchView: View {
    @State private var searchText: String = ""
    //드롭다운바 즉,Picker에서 사용하기 위한 사용자가 선택한 옵션을 저장,이 값을 사용하여 리스트를 정렬 1~3까지의 값이 있음,추가될 수 있음
    @State private var sortOption: Int = 0
    //입력필드에서 사용되는 힌트
    
    @State private var placeHolder: String = "가고싶은 시장을 입력하세요"
    @State private var MarketList: [Document] = []
    @State private var errorMessage: String?
    @ObservedObject var locationManager = LocationManager()
    @State private var selectedMarket: Document?
    @State private var isLoading = false // indicator 추가
    @StateObject var vm = MarketSearchViewModel()
    
    var sortedClasses: [Document] {
        switch sortOption {
            case 0: return MarketList.sorted(by: { Int($0.distance)! < Int($1.distance)! })
                //                case 1: return MarketList.sorted(by: { $0.rating > $1.rating })
            case 2: return MarketList.sorted(by: { $0.placeName < $1.placeName })
            default: return MarketList
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                    SearchBar(searchText: $searchText,placeHolder: $placeHolder)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                    } else {
                        if isLoading {
                            
                            ProgressView()
                                .scaleEffect(2)
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .frame(width: 100, height: 100)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(20)
                                .shadow(radius: 10)
                            Spacer()
  
                        
                        } else {
                            
                            //                        MarketMapView(marketList: $MarketList, selectedMarket: $selectedMarket)
                            MarketSearchOtherTableWrapper(data: MarketList, selected: $selectedMarket,vm:vm, isLoading: $isLoading)
                            
                            
                        }
                        
                    }
                    
                }
            }
            
            
            
        }
        
    }
}
