//
//  HomeView.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 30.04.2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewModel = HomeViewViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                header
                Spacer()
                list
            }
            .gesture(DragGesture().onChanged({ _ in
                self.endEditing()
            }))
        }
        .padding(0)
        .onAppear {
            homeViewModel.fetchUniversities()
        }
    }
}

extension HomeView {
    
    var header: some View {
        VStack(alignment: .center) {
            Text("Список вузов")
                .fontDesign(.rounded)
                .fontWeight(.regular)
                .font(.title)
            TextField("Поиск", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .onChange(of: searchText, initial: true, { _, newValue in
                    homeViewModel.searchText = newValue
                })
        }
        .padding(.horizontal, 16.adjustSize())
    }
    
    var list: some View {
        List {
            ForEach(homeViewModel.universities, id: \.self) { uniInfo in
                NavigationLink(destination: UniDetailView(universityId: uniInfo.id)) {
                    UniRow(uniInfo: uniInfo)
                }
            }
        }
        .listStyle(.plain)
    }
}

struct CustomButton: View {
    
    var image: String
    var action: () -> ()
    
    var body: some View {
        Circle()
            .frame(width: 40.adjustSize(), height: 40.adjustSize())
            .foregroundColor(.white)
            .shadow(color: .secondary.opacity(0.5), radius: 3.adjustSize(), x: 0.0, y: 0.0)
            .overlay(alignment: .center) {
                Button(action: action, label: {
                    Image(systemName: image)
                        .resizable()
                        .frame(width: 15.adjustSize(), height: 15.adjustSize())
                        .aspectRatio(contentMode: .fit)
                        .tint(.primary.opacity(0.8))
                })
            }
    }
}

struct UniRow: View {
    
    let uniInfo: University
    
    var body: some View {
        let baseURL = URL(fileURLWithPath: "/Users/a4rek0v/Documents/Магистратура/Методология и технология проектирования информационных систем/КР/UniSearch")
        let imagePath = String(uniInfo.bigPhoto.dropFirst()) // Удаляем первый символ из строки
        let fullURL = baseURL.appendingPathComponent(imagePath)
        
        let image: Image
        if let uiImage = UIImage(contentsOfFile: fullURL.path) {
            image = Image(uiImage: uiImage)
        } else {
            image = Image("example")
        }
        
        return VStack(alignment: .leading, spacing: 5.adjustSize()) {
            image
                .resizable()
                .frame(height: 400)
                .scaledToFit()
                .overlay(alignment: .topLeading) {
                    HStack {
                        Image(systemName: "location.fill")
                        Text(uniInfo.address ?? "Санкт-Петербург")
                            .fontWeight(.regular)
                            .font(.system(size: 12.adjustSize()))
                    }
                    .padding(8.adjustSize())
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10.adjustSize()))
                    .padding(5.adjustSize())
                }
            
            Text(uniInfo.name)
                .font(.headline)
        }
    }
}


#Preview {
    HomeView()
}
