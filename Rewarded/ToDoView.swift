//
//  ToDoView.swift
//  Rewarded
//
//  Created by Ethan AK on 4/22/25.
//
import SwiftUI

struct ToDoView: View {
    @State var isClassDone = false
    @State var isHomeworkDone = false
    @State var isDinnerDone = false
    @State var isDayDone = false
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Button {
                        isClassDone.toggle()
                    } label: {
                        Image(systemName: isClassDone ? "checkmark.square.fill" : "square")
                    }
                    Text("Go to class")
                }
                
                HStack {
                    Button {
                        isHomeworkDone.toggle()
                    } label: {
                        Image(systemName: isHomeworkDone ? "checkmark.square.fill" : "square")
                    }
                    Text("Finish homework")
                }
                
                HStack {
                    Button {
                        isDinnerDone.toggle()
                    } label: {
                        Image(systemName: isDinnerDone ? "checkmark.square.fill" : "square")
                    }
                    Text("Make dinner")
                }
                
                HStack {
                    Button {
                        isDayDone.toggle()
                    } label: {
                        Image(systemName: isDayDone ? "checkmark.square.fill" : "square")
                    }
                    Text("Go to sleep")
                }
            }
            .navigationTitle("Todo")
        }
    }
}

#Preview {
    ToDoView()
}
