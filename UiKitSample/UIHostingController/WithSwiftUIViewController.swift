//
//  WithSwiftUIViewController.swift
//  UiKitSample
//
//  Created by Ryo Narisawa on 2021/05/18.
//

import Foundation
import UIKit
import Combine
import SwiftUI

final class WithSwiftUIViewController : ViewController {
    
    @IBOutlet weak var showSwiftUITextLabel: UILabel!
    @IBOutlet weak var vStackView: UIStackView!
    private var viewModel = ViewModel()
    private var cancellables = [AnyCancellable]()
    
    private let fromSwiftUITextLabelPreffix = "Textfield入力値:"
    
    override func viewDidLoad() {
        let vc = UIHostingController(rootView: SubView(viewModel: self.viewModel))
        addChild(vc)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vStackView.addArrangedSubview(vc.view)
        vc.didMove(toParent: self)
        
        // Publisherを監視
        viewModel.$swiftUIText.sink(receiveValue: { text in
            self.showSwiftUITextLabel.text =  "\(self.fromSwiftUITextLabelPreffix) \(text)"
        }).store(in: &cancellables)
        
        showSwiftUITextLabel.text =  fromSwiftUITextLabelPreffix
    }
}

struct SubView : View {
    @StateObject var viewModel : ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("SwiftUI").font(.title).padding(4)
            TextField("TextField", text: $viewModel.swiftUIText).textFieldStyle(RoundedBorderTextFieldStyle()).font(.title3).padding(8)
        }.background(Color.pink)
    }
}

class ViewModel : ObservableObject {
    @Published var swiftUIText = ""
}
