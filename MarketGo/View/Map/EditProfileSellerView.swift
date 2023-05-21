import SwiftUI
import Alamofire

struct StoreUpdateView: View {
    @ObservedObject var obse: ObservableStoreElement
    @State private var storeName: String = ""
    @State private var storeAddress1: String = ""
    @State private var storeAddress2: String = ""

    
    var body: some View {
        VStack {
            Form {
                TextField("Store Name", text: $storeName)
                TextField("Store Address 1", text: $storeAddress1)
                TextField("Store Address 2", text: $storeAddress2)
                // Add more fields as needed
            }
            .onAppear(perform: loadStoreData)
            .navigationTitle("Update Store")
            .navigationBarItems(trailing: Button("Save Changes") {
                obse.storeElement.storeName = storeName
                obse.storeElement.storeAddress1 = storeAddress1
                obse.storeElement.storeAddress2 = storeAddress2
                updateStoreData()
            })

            Button(action: updateStoreData) {
                Text("Update")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
    
    func loadStoreData() {
        storeName = obse.storeElement.storeName ?? ""
        storeAddress1 = obse.storeElement.storeAddress1 ?? ""
        storeAddress2 = obse.storeElement.storeAddress2 ?? ""
    }


    func updateStoreData() {
        
        obse.storeElement.storeName = storeName
        print(storeName)
        print(obse.storeElement.storeName)
        obse.storeElement.storeAddress1 = storeAddress1
        obse.storeElement.storeAddress2 = storeAddress2
        print(obse.storeElement.storeRatings)
        print(obse.storeElement.storeInfo)
        let parameters: [String: Any] = [
            "storeName": obse.storeElement.storeName!,
            "storeAddress1": obse.storeElement.storeAddress1!,
            "storeAddress2": obse.storeElement.storeAddress2!,
            "storeRatings": 0.0,
            "storePhonenum": "Store Phone Number",
            "storeInfo": "Store Information",
            "cardAvail": "Card Availability Information",
            "localAvail": "Local Availability Information",
            "storeNum": 0,
            "marketId": 0,
            "storeFile": 0,
            "storeCategory": 0
        ]

        let url = "http://3.34.33.15:8080/store/96"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        

        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .response { response in
                debugPrint(response)
            }
        
    }
}

extension StoreElement {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
class ObservableStoreElement: ObservableObject {
    @Published var storeElement: StoreElement

    init(storeElement: StoreElement) {
        self.storeElement = storeElement
    }
}