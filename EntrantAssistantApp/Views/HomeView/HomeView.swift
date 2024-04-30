//
//  HomeView.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 30.04.2024.
//

import SwiftUI

struct HomeView: View {
    
    let unis = MockData.getAllUnis()
    
    var body: some View {
        VStack {
            header
            Spacer()
            List {
                ForEach(unis, id: \.self) { uniInfo in
                    UniRow(uniInfo: uniInfo)
                }
            }
            .listStyle(.plain)
        }
    }
}

extension HomeView {
    
    var header: some View {
        HStack(alignment: .center) {
            CustomButton(image: "magnifyingglass") {
                print(1)
            }
            Spacer()
            Text("Список вузов")
                .fontDesign(.rounded)
                .fontWeight(.regular)
                .font(.title)
            Spacer()
            CustomButton(image: "line.3.horizontal.decrease") {
                print(1)
            }
        }
        .padding(.horizontal, 16.adjustSize())
    }
}

struct CustomButton: View {
    
    var image: String
    var action: () -> ()
    
    var body: some View {
        Circle()
            .frame(width: 40.adjustSize(), height: 40.adjustSize())
            .foregroundColor(.white)
            .shadow(color: .secondary.opacity(0.5), radius: 3.adjustSize(), x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
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
    
    let uniInfo: UniInfoStruct
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            Image(uniInfo.image)
                .resizable()
                .frame(height: 180.adjustSize(), alignment: .center)
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10.adjustSize()))
                .overlay(alignment: .topLeading) {
                    HStack {
                        Image(systemName: "location.fill")
                        Text(uniInfo.locationName)
                            .fontWeight(.regular)
                    }
                    .padding(8.adjustSize())
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10.adjustSize()))
                    .padding(5.adjustSize())
                }
            Text(uniInfo.name)
                .font(.headline)
            Text("Позиция в рейтинге: \(uniInfo.rating)")
                .font(.subheadline)
        }
    }
}

#Preview {
    HomeView()
}
