import SwiftUI
import SwiftData


struct ContentView: View {
    @State private var selectedJob: Job? = nil
    @State private var showAddJobView = false
    @State private var favorite: Bool = false
    @AppStorage("fontsize") private var textSize : Double = 16.0
    @AppStorage("username") private var username: String = ""
    
    @Environment(\.modelContext) var context
    @Query(sort: \Job.date, order: .reverse)
    private var job: [Job]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10){
                Image("header")
                    .resizable()
                    .frame(width: 500,height: 250)
                    .shadow(color: .white, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
             
                VStack {
                    List {
                        if !job.isEmpty {
                            ForEach(job) { job in
                                HStack{
                                    if let imageName = job.imageName, let uiImage = UIImage(named: imageName) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .aspectRatio(contentMode: .fit)
                                            .padding(1)
                                    }
                                    
                                    Text(job.titel)
                                        .font(.system(size: textSize))
                                    if job.favorite == true {
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
                                    }
                                    
                                    .swipeActions(edge: .trailing) {
                                        Button(
                                            role: .destructive,
                                            action: {
                                                context.delete(job)
                                            },
                                            label:  {
                                                Label("delete", systemImage: "trash")
                                            }
                                        )
                                    }
                                    
                                    .swipeActions(edge: .leading) {
                                        Button(action: {
                                            job.favorite.toggle()
                                        }) {
                                            if job.favorite {
                                                Label("Unfavorite", systemImage: "star.slash.fill")
                                            } else {
                                                Label("Favorite", systemImage: "star.fill")
                                            }
                                        }
                                        .tint(job.favorite ? .gray : .yellow)
                                        
                                    }
                                    .padding(1)
                                    
                                }
                            }
                            
                        } else {
                            Text("no Jobs found!")
                        }
                    }
                }
            }
            .navigationTitle("Welcome \(username) to DreamJobs")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedJob) { job in
                JobDetailView(job: job)
            }
        }
    }
}



#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Job.self, configurations: configuration)
    
    
    let context = ModelContext(container)
    let sampleJob = Job(titel: "Sample Job", details: "Sample details", salary: 1000.0, favorite: true, imageName: "image1", skills: [Skill(titel: "Sample Skill")])
    context.insert(sampleJob)
    
    return ContentView()
        .modelContainer(container)
}



