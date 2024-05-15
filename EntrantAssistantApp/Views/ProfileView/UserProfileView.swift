//
//  UserProfileView.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 13.05.2024.
//

import SwiftUI

struct UserProfileView: View {
    
    @StateObject private var profileViewModel = ProfileViewModel()
    @State private var userID = String()
    @State private var isUniesExpanded = false
    @State private var isProgramsExpanded = false
    @State private var isExamsExpended = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 16.adjustSize()) {
                    if let userDetail = profileViewModel.userDetail {
                        topUserInfo(userDetail: userDetail)
                        DisclosureGroup(isExpanded: $isExamsExpended) {
                            subjectsList(exams: userDetail.exams)
                        } label: {
                            userSubjects
                                .tint(.black)
                        }
                        DisclosureGroup(isExpanded: $isUniesExpanded) {
                            selectedUniesList(unis: userDetail.unis)
                        } label: {
                            selectedUniesLabel
                                .tint(.black)
                        }
                        DisclosureGroup(isExpanded: $isProgramsExpanded) {
                            selectedProgramsList(programs: userDetail.programs)
                        } label: {
                            selectedProgramsLabel
                                .tint(.black)
                        }
                    } else if let errorMessage = profileViewModel.errorMessage {
                        Text(errorMessage)
                    } else {
                        ProgressView()
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Профиль")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        UserDefaults.standard.removeObject(forKey: "UserID")
                        userID = ""
                    }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                    }
                }
            }
            .fullScreenCover(isPresented: userID == "" ? .constant(true) : .constant(false)) {
                AuthView()
            }
        }
        .onAppear {
            if let userID = UserDefaults.standard.string(forKey: "UserID") {
                self.userID = userID
                profileViewModel.fetchUserProfile(userId: userID)
            }
        }
    }
}

extension UserProfileView {
    func topUserInfo(userDetail: UserDetail) -> some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 50.adjustSize(), height: 50.adjustSize())
            VStack(alignment: .leading) {
                Text("\(userDetail.name)")
                Text("\(userDetail.birthdate)")
            }
            Spacer()
            VStack {
                Text("Суммарный балл")
                    .font(.subheadline)
                Spacer()
                Text("\(userDetail.exams.map({ $0.points }).reduce(0, +))")
                    .font(.headline)
            }
        }
    }
    
    var userSubjects: some View {
        Text("Ваши предметы")
            .font(.title2)
            .fontWeight(.semibold)
    }
    
    func subjectsList(exams: [Exam]) -> some View {
        VStack(alignment: .leading, spacing: 8.adjustSize()) {
            ForEach(exams, id: \.id) { exam in
                subjectCell(exam: exam)
            }
        }
        .listStyle(.plain)
    }
    
    func subjectCell(exam: Exam) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.adjustSize()) {
                Text("Название предмета")
                    .font(.subheadline)
                Text(exam.name)
                    .font(.headline)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 8.adjustSize()) {
                Text("Баллы за ЕГЭ")
                    .font(.subheadline)
                Text("\(exam.points)")
                    .font(.headline)
            }
        }
        .padding(.vertical, 12)
    }
    
    var selectedUniesLabel: some View {
        Text("Выбранные вузы")
            .font(.title2)
            .fontWeight(.semibold)
    }
    
    func selectedUniesList(unis: [Uni]) -> some View {
        VStack(alignment: .leading, spacing: 8.adjustSize()) {
            ForEach(unis, id: \.id) { uni in
                Text(uni.name)
                    .font(.subheadline)
                    .padding(.vertical, 12)
            }
        }
        .listStyle(.plain)
    }
    
    var selectedProgramsLabel: some View {
        Text("Выбранные программы")
            .font(.title2)
            .fontWeight(.semibold)
    }
    
    func selectedProgramsList(programs: [Prog]) -> some View {
        VStack(alignment: .leading, spacing: 8.adjustSize()) {
            ForEach(programs, id: \.code) { program in
                programCell(program: program)
            }
        }
        .listStyle(.plain)
    }
    
    func programCell(program: Prog) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8.adjustSize()) {
                Text("Код программы")
                    .font(.subheadline)
                Text(program.code)
                    .font(.headline)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 8.adjustSize()) {
                Text("Название программы")
                    .font(.subheadline)
                Text(program.name)
                    .font(.headline)
            }
        }
        .padding(.vertical, 12)
    }
}
#Preview {
    UserProfileView()
}
