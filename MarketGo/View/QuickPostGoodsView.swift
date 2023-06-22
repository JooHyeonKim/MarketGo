import SwiftUI
import Alamofire
import UIKit

struct QuickPostGoodsView: View {
    @ObservedObject var viewModel:PostGoodsViewModel
    
    @EnvironmentObject var userViewModel: UserModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var isImagePickerPresented = false
    @State var isEnroll = false
    var body: some View {
        VStack {
            Form {
                ImageUploadView(category: $viewModel.imageCate.categoryName, selectedImage: $viewModel.selectedImage, newImage: $viewModel.newImage)
                    .padding(.bottom)
                TextField("상품명", text: $viewModel.goodsName)
                TextField("가격", text: $viewModel.goodsPrice)
                TextField("단위", text: $viewModel.goodsUnit)
                TextField("원산지", text: $viewModel.goodsOrigin)
                TextField("물품 설명", text: $viewModel.goodsInfo)
            }
        }
        .onAppear(perform: loadView)
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: alertItem.dismissButton
            )
        }
        .onChange(of: viewModel.alertDismissed) { dismissed in
            if dismissed {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .sheet(isPresented: $isImagePickerPresented, onDismiss: {
            if viewModel.selectedImage != nil {
                print("이미지선택완료")
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            ImagePicker(image: $viewModel.selectedImage)
        }
        
        Button(action: {
            Task{
                isEnroll = true
                await viewModel.postGoods()
            }
        }) {
            Text("등록")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    func loadView() {
        if let storeid = userViewModel.currentUser?.storeID?.storeID {
            viewModel.storeId = storeid
        }
        if let marketid = userViewModel.currentUser?.storeID?.storeMarketID?.marketID {
            viewModel.marketId = marketid
        }
    }
}
struct QuickView: View {
    @StateObject private var vm = PostGoodsViewModel()
    @StateObject private var nvm = NaverViewModel()
    @State private var isShowingImagePicker = false
    @State private var isShowingQuickPostGoodsView = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        
        ZStack{
            VStack {
                NavigationLink(
//                    destination: QuickPostGoodsView(viewModel: vm),
                    destination: NaverView(),
                    isActive: $isShowingQuickPostGoodsView,
                    label: {
                        EmptyView()
                    }
                )
                
                Button(action: {
                    isShowingImagePicker = true
                }) {
                    Text("가격표를 찍어서 \n빠르게 상품을 등록해보세요")
                        .font(.system(size: 20))
                        .padding()
                        .font(.subheadline)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isShowingImagePicker, onDismiss: {
                    if selectedImage != nil {
                        nvm.image=selectedImage!
                        vm.isLoading = true
                        nvm.changeImageToText()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            
                            Task{
//                                if let image = selectedImage?.size.width, image == 732.0 {
//                                    vm.text = "1"
//                                } else {
//                                    vm.text = "2"
//
//                                }
                                vm.text = nvm.stringResult
//                                print("size",selectedImage?.size)
    
                                vm.fetchImageData()
                                
                                isShowingQuickPostGoodsView = true
                                vm.isLoading = false
                            }
                            
                            
                        }
                    }
                }) {
                    ImagePicker(image: $selectedImage)
                }
                
            }
            if vm.isLoading {
                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .frame(width: 100, height: 100)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    .shadow(radius: 10)
            }
        }
        .navigationTitle("빠른 상품 등록")
        
    }
}
