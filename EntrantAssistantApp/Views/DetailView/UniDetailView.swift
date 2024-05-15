//
//  UniDetailView.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 30.04.2024.
//

import SwiftUI

struct UniDetailView: View {
    @StateObject private var viewModel = DetailViewModel()
    let universityId: Int

    var body: some View {
        ScrollView(.vertical) {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.error {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else if let university = viewModel.universityDetail {
                VStack(alignment: .leading, spacing: 8) {
                    image(url: university.bigPhoto)
                    name(text: university.name)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        address(text: university.address ?? "Адрес отсутствует")
                        vuzopediaRating(id: university.vuzopediaID)
                        description(text: university.info ?? "Описание отсутсвует")
                        programsLabel
                        programsList(programs: university.programs)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .toolbar(content: {
            Button {
                print("added")
            } label: {
                Image(systemName: "star")
                    .tint(.yellow)
            }
        })
        .onAppear {
            viewModel.fetchUniversityDetail(id: universityId)
        }
    }
}

extension UniDetailView {
    func image(url: String) -> some View {
        let baseURL = URL(fileURLWithPath: "/Users/a4rek0v/Documents/Магистратура/Методология и технология проектирования информационных систем/КР/UniSearch")
        let imagePath = String(url.dropFirst()) // Удаляем первый символ из строки
        let fullURL = baseURL.appendingPathComponent(imagePath)
        
        if let image = UIImage(contentsOfFile: fullURL.path) {
            return AnyView(
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 400)
                    .scaledToFit()
            )
        } else {
            return AnyView(
                Image("example")
                    .resizable()
                    .frame(height: 400)
                    .scaledToFit()
            )
        }
    }


    
    func name(text: String) -> some View {
        Text(text)
            .font(.title)
            .fontWeight(.semibold)
            .lineLimit(3)
    }
    
    func address(text: String) -> some View {
        Text("Адрес вуза: \(text)")
    }
    
    func vuzopediaRating(id: Int) -> some View {
        Text("Рейтинг в vuzopedia: \(id)")
    }
    
    func description(text: String) -> some View {
        Text(text)
    }
    
    var programsLabel: some View {
        Text("Программы")
            .font(.title2)
            .fontWeight(.semibold)
    }
    
    func programsList(programs: [Program]) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(programs) { program in
                HStack {
                    Text(program.code)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(program.name)
                        .font(.body)
                }
                .padding(.vertical, 2)
            }
        }
    }
}

#Preview {
    UniDetailView(universityId: 76)
}
