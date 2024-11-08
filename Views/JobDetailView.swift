//
//  JobDetailView.swift
//  TraumJobs
//
//  Created by Eggenschwiler Andre on 16.09.24.
//





import SwiftUI
import SwiftData

struct JobDetailView: View {
    @State private var selectedImage: UIImage? = nil
    @AppStorage("fontsize") private var textSize : Double = 16.0
   
    let job: Job
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading ) {
                HStack{
                    Text(job.titel)
                        .font(.title)
                        .padding()
                    
                    Spacer()
                    if job.favorite {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: textSize))
                            .padding()
                    }
                    
                }
                Text(job.details)
                    .font(.system(size: textSize))
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("Skills:")
                        .font(.title)
                        .padding(.bottom, 5)
                    ForEach(job.skills, id: \.id) { skill in
                        Text(skill.titel)
                            .font(.system(size: textSize))
                            .padding(2)
                    }
                }
                .padding()
                
                Text("Salary: \(job.salary, format: .number) Euro")
                    .font(.system(size: textSize))
                    .padding()
                
                Text("\(job.date.formatted(.dateTime))")
                    .font(.system(size: textSize))
                    .padding()
                
            }
        }
        .padding()
        
        if let imageName = job.imageName, let uiImage = UIImage(named: imageName) {
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                .aspectRatio(contentMode: .fit)
                .padding()
        } else {
            Text("No image available")
                .foregroundColor(.gray)
                .padding()
        }
    }
}


#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Job.self, configurations: configuration)

   
    let context = ModelContext(container)
    let sampleJob = Job(titel: "Sample Job", details: "Sample details", salary: 1000.0, favorite: true, imageName: "image1", skills: [Skill(titel: "Skill"), Skill(titel: "Sample Skill")])
    context.insert(sampleJob)

    return JobDetailView(job: sampleJob)
        .modelContainer(container)
}

