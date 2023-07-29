//
//  ContentView.swift
//  Project 11
//
//  Created by Pedro Pablo on 26/07/23.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title, order: .reverse),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 
 ##### Data model
 
 struct ContentView: View {
     @Environment(\.managedObjectContext) var moc //Acceder al data model
     @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>

     var body: some View {
         VStack {
             List(students) { student in
                 Text(student.name ?? "Unknown")
             }
             
             Button("Add") {
                 let firstNames = ["Ginny", "Harringi", "Hermione", "Luna", "Colorado alcahuete"]
                 let lastNames = ["Granger", "Lovegood", "Potter", "Wasley"]
                 
                 let chosenFirstName = firstNames.randomElement()!
                 let chosenLastName = lastNames.randomElement()!
                 
                 let student = Student(context: moc)
                 student.id = UUID()
                 student.name = "\(chosenFirstName) \(chosenLastName)"
                 
                 try? moc.save()
                 
             }
             
         }
     }
     
 }
 
 
 ####### TextEditor   #######
 
 struct ContentView: View {
     @AppStorage("notes") private var notes = ""

     var body: some View {
         NavigationView {
             TextEditor(text: $notes)
                 .navigationTitle("Notes")
                 .padding()
         }
     }
     
 }
 
 
 
 ####### BINDING   #######
 
 struct PushButton: View {
     let title: String
     @Binding var isOn: Bool
     
     var onColors = [Color.red, Color.yellow]
     var offColors = [Color(white: 0.6), Color(white: 0.4)]
     
     var body: some View {
         Button(title) {
             isOn.toggle()
         }
         .padding()
         .background(
             LinearGradient(gradient: Gradient(colors: isOn ? onColors: offColors), startPoint: .top, endPoint: .bottom)
         )
         .foregroundColor(.white)
         .clipShape(Capsule())
         .shadow(radius: isOn ? 0: 5)
     }
 }

 struct ContentView: View {
     @State private var rememberMe = false
     
     var body: some View {
         VStack {
             PushButton(title: "Remember me", isOn: $rememberMe)
             Text(rememberMe ? "On": "Off")
         }
     }
 }
 
 
 */
