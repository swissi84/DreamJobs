//
//  JobAddView.swift
//  TraumJobs
//
//  Created by Eggenschwiler Andre on 16.09.24.
//





import SwiftUI
import SwiftData

struct JobAddView: View {
    @State private var titel = ""
    @State private var detail = ""
    @State private var salary = 0.0
    @State private var favorite: Bool = false
    @State private var alert: Bool = false
    @State private var selectedJob: Job? = nil
    @State private var newSkillTitle: String = ""
    @State private var isAddingSkill = false
    @State private var selectedImageName: String? = nil
    @AppStorage("fontsize") private var textSize : Double = 16.0
   
    let availableImages = ["image1", "image2", "image3", "image4"]
    
    @State private var selectedSkill: [Skill] = []
    
    @Environment(\.modelContext) var context
    @Query(sort: \Job.date, order: .reverse) private var job: [Job]
    
    @Query private var allskills: [Skill]
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("Job Name:")
                    TextField("Titel", text: $titel)
                    
                    Spacer().frame(height: 20)
                    
                    Text("Job Description:")
                    TextField("Details", text: $detail)
                    
                    Spacer().frame(height: 20)
                    
                    Text("Salary in Euro:")
                    TextField("Salary", value: $salary, format: .number)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(allskills, id: \.id) { skill in
                                Button(action: {
                                    if selectedSkill.contains(where: { $0.id == skill.id }) {
                                        selectedSkill.removeAll { $0.id == skill.id }
                                    } else {
                                        selectedSkill.append(skill)
                                    }
                                }) {
                                    Text(skill.titel)
                                        .padding(5)
                                        .background(selectedSkill.contains(where: { $0.id == skill.id }) ? Color.blue : Color.gray)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                }
                                .padding(5)
                            }
                        }
                    }
                    
                    
                    Section(header: Text("Select an Image")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(availableImages, id: \.self) { imageName in
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .border(selectedImageName == imageName ? Color.blue : Color.clear, width: 3)
                                        .onTapGesture {
                                            selectedImageName = imageName
                                        }
                                    
                                }
                            }
                        }
                    }
                }
                .padding()
                
                HStack(alignment: .center) {
                    if !titel.isEmpty && !detail.isEmpty {
                        Button("Save") {
                            
                            let addNewJob = Job(
                                titel: titel,
                                details: detail,
                                salary: salary,
                                favorite: favorite,
                                imageName: selectedImageName,
                                skills: []
                            )
                            
                            
                            context.insert(addNewJob)
                            addNewJob.skills = selectedSkill
                            
                            do {
                                try context.save()
                            } catch {
                                print("Failed to save context: \(error)")
                            }
                            
                            
                            titel = ""
                            detail = ""
                            salary = 0.0
                            favorite = false
                            selectedSkill = []
                            selectedImageName = nil
                        }
                        .frame(width: 100, height: 50)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 10, x: 5, y: 5)
                        .padding()
                    } else {
                        Button("Save") {
                            alert = true
                        }
                        .frame(width: 100, height: 50)
                        .foregroundColor(Color.white)
                        .background(Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 10, x: 5, y: 5)
                        .padding()
                        .alert(isPresented: $alert) {
                            Alert(
                                title: Text("Incomplete Information"),
                                message: Text("Please fill in all fields before saving."),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                }
                .padding(1)
                
                VStack {
                    List {
                        if !job.isEmpty {
                            ForEach(job) { job in
                                HStack {
                                    Text(job.titel)
                                        .font(.system(size: textSize))
                                    if job.favorite {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .font(.system(size: textSize))
                                    }
                                    
                                    Spacer()
                                    Text("\(job.salary, format: .number) Euro")
                                        .font(.system(size: textSize))
                                    Button(action: {
                                        selectedJob = job
                                    }) {
                                        Image(systemName: "info.circle")
                                            .foregroundColor(.blue)
                                            .font(.system(size: textSize))
                                    }
                                }
                            }
                        } else {
                            Text("No jobs found")
                        }
                    }
                }
                .navigationTitle("Add Job")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(item: $selectedJob) { job in
                    JobDetailView(job: job)
                }
                .navigationBarItems(trailing: Button(action: {
                    isAddingSkill = true
                }) {
                    Text("Add New Skill")
                })
                .sheet(isPresented: $isAddingSkill) {
                    VStack {
                        TextField("Enter new skill", text: $newSkillTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button("Save") {
                            guard !newSkillTitle.isEmpty else { return }
                            let newSkill = Skill(titel: newSkillTitle)
                            context.insert(newSkill)
                            newSkillTitle = ""
                            isAddingSkill = false
                        }
                        .padding()
                        .disabled(newSkillTitle.isEmpty)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Job.self, configurations: configuration)

   
    let context = ModelContext(container)
    let sampleJob = Job(titel: "Sample Job", details: "Sample details", salary: 1000.0, favorite: true, imageName: "image1", skills: [Skill(titel: "Skill"), Skill(titel: "Sample Skill")])
    context.insert(sampleJob)

    return JobAddView()
        .modelContainer(container)
}
