//
//  ContentView.swift
//  Rateit
//
//  Created by Samuel Kreyenbühl on 04.09.23.
//

import SwiftUI
import CoreData
import CodeScanner

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    @State private var image:UIImage?
    
    var body: some View {
        VStack(spacing: 10) {
            if let code = scannedCode {
                NextView(scannedCode: code, scannedImage: image)
            }
            
            Button("Scan Code") {
                isPresentingScanner = true
            }
            
            Text("Scan a QR code to begin")
        }
        .sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [
                .qr,
                .code39,
                .code39Mod43,
                .code93,
                .code128,
                .ean8,
                .ean13,
                .pdf417,
                .aztec,
                .dataMatrix,
                .interleaved2of5,
                .itf14,
                .upce,
                .microPDF417,
                .qr,
                .aztec,
                .interleaved2of5,
                .itf14,
                .upce,
                .microPDF417,
                .codabar,
                .gs1DataBar,
                .gs1DataBarExpanded,
                .gs1DataBarLimited,
                .microQR
            ]
) { response in
                switch response {
                case .success(let result):
                    scannedCode = result.string
                    image = result.image
                case .failure(let error):
                    scannedCode = error.localizedDescription
                }
                print(scannedCode!)
                isPresentingScanner = false
            }
        }
    }
}

struct NextView: View {
    let scannedCode:String
    let scannedImage:UIImage?
    var body: some View {
        VStack{
            Text(scannedCode)
            if let image = scannedImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
