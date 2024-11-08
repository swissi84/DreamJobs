//
//  FavoriteView.swift
//  TraumJobs
//
//  Created by Eggenschwiler Andre on 18.09.24.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @State private var selectedJob: Job? = nil
    @AppStorage("fontsize") private var textSize : Double = 16.0
    
    @Environment(\.modelContext) private var context
    
    @Query(filter: #Predicate { $0.favorite == true }, sort: \Job.salary, order: .reverse)
    private var favoriteJobs: [Job]  
    
    var body: some View {
        NavigationStack {
            if favoriteJobs.isEmpty {
                Spacer()
                Text("No Favorite Jobs Found!")
                Spacer()
            } else {
                List {
                    ForEach(favoriteJobs) { job in
                        HStack() {
                            Text(job.titel)
                                .font(.system(size: textSize))
                            if job.favorite == true {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                
                            }
                            
                            
                            Spacer()
                            Text("\(job.salary, format: .number) Euro")
                                .font(.system(size: textSize))
                            Button(action: {
                                selectedJob = job
                            }) {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.blue)
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button(
                                role: .destructive,
                                action: {
                                    context.delete(job)
                                },
                                label:  {
                                    Label("Löschen", systemImage: "trash")
                                }
                            )
                        }
                    }
                }
                .toolbar {
                    Button("Delete") {
                        
                        for job in favoriteJobs {
                            context.delete(job)
                        }
                        
                    }
                }
                .navigationTitle("Favorite Jobs")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(item: $selectedJob) { job in
                    JobDetailView(job: job)
                }
            }
        }
    }
}
#Preview {
    FavoriteView()
}
