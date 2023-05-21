//
//  MypageView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import SwiftUI


struct UserMyPageView: View {
    @EnvironmentObject var userModel: UserModel

    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 20)
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width:100, height:100)
            
            Spacer().frame(height: 20)
            
            HStack {
                Text("이름")
                Spacer()
                Text("\(userModel.currentUser?.memberName ?? "")")
                
                
            }
            HStack {
                Text("관심 시장")
                Spacer()
                Text("\(userModel.currentUser?.interestMarket?.marketName ?? "")")
            }
            HStack {
                Text("장바구니")
                Spacer()
                //Text("\(userModel.currentUser?.cartID ?? 0)")
            }
            HStack {
                Text("member id")
                Spacer()
                Text("\(userModel.currentUser?.memberID ?? 0)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("My Page", displayMode: .inline)
    }
}