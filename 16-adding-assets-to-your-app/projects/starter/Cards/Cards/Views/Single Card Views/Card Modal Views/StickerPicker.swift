/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct StickerPicker: View {
    @State private var stickerNames: [String] = []
    @Binding var stickerImage: UIImage?
    @Environment(\.presentationMode) var presentationMode

    let columns = [
        GridItem(.adaptive(minimum: 120, maximum: 10))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(stickerNames, id: \.self) { sticker in
                    Image(uiImage: image(from: sticker))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            stickerImage = image(from: sticker)
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
        }
        .onAppear {
            stickerNames = loadStickers()
        }
    }

    func loadStickers() -> [String] {
        var themes: [URL] = []
        var stickerNames: [String] = []

        let fileManager = FileManager.default
        if let resourcePath = Bundle.main.resourcePath, let enumerator = fileManager.enumerator(at: URL(fileURLWithPath: resourcePath + "/Stickers"), includingPropertiesForKeys: nil, options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants]) {
            for case let url as URL in enumerator where url.hasDirectoryPath {
                themes.append(url)
            }
        }

        for theme in themes {
            if let files = try? fileManager.contentsOfDirectory(atPath: theme.path) {
                for file in files {
                    stickerNames.append(theme.path + "/" + file)
                }
            }
        }

        return stickerNames
    }

    func image(from path: String) -> UIImage {
        print("loading:", path)
        return UIImage(named: path) ?? UIImage(named: "error-image") ?? UIImage()
    }

}

struct StickerPicker_Previews: PreviewProvider {
    static var previews: some View {
        StickerPicker(stickerImage: .constant(UIImage()))
    }
}
