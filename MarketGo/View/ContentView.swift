//
//  ContentView.swift
//  MarketGo
//
//  Created by ram on 2023/03/27.
//
import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    @State private var selectedMarket: MarketOneElement?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                Image("상도시장메인")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Picker(selection: $selectedTab, label: Text("탭")) {
                    Text("시장정보").tag(0)
                    Text("지도보기").tag(1)
                    Text("가는길 찾기").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedTab {
                    case 0:
                        MarketListView(marketData: $selectedMarket)
                    case 1:
//                        MarketOneMapView(selectedMarket: $selectedMarket)
//                            .frame(height: geometry.size.height * 0.3)
                        
                        Image("상도시장지도")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            
                        
                        Spacer().frame(width:20)
                    case 2:
                        FindPathView(selectedMarket: $selectedMarket)
                    default:
                        Text("잘못된 선택")
                }
            }
        }
        .navigationTitle((selectedMarket?.marketName ?? "null"))
    }
}
