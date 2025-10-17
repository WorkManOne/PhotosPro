import SwiftUI

struct TasksView: View {
    @EnvironmentObject var userService: UserService
    @State private var selectedStatus: TaskStatus? = nil
    @State private var selectedCategory: TaskCategory? = nil
    @State private var searchText = ""
    
    var filteredTasks: [TaskModel] {
        var filtered = userService.tasks
        
        if let status = selectedStatus {
            filtered = filtered.filter { $0.status == status }
        }
        
        if let category = selectedCategory {
            filtered = filtered.filter { $0.category == category }
        }
        
        if !searchText.isEmpty {
            filtered = filtered.filter { 
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText) ||
                $0.clientName?.localizedCaseInsensitiveContains(searchText) == true
            }
        }
        
        return filtered.sorted { $0.priority.rawValue > $1.priority.rawValue }
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ScrollView {
                    LazyVStack(spacing: 15) {
                        VStack(spacing: 5) {
                            Text("\(userService.tasks.count)")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.gradientBlue)
                            Text("Total Tasks")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                Button(action: {
                                    selectedStatus = nil
                                }) {
                                    Text("All")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(selectedStatus == nil ? .backgroundMain : .titleGrayMain)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(selectedStatus == nil ? .gradientBlue : .surfaceGray)
                                        )
                                }
                                
                                ForEach(TaskStatus.allCases, id: \.self) { status in
                                    Button(action: {
                                        selectedStatus = status
                                    }) {
                                        Text(status.rawValue)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(selectedStatus == status ? .backgroundMain : .titleGrayMain)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(selectedStatus == status ? status.color : .darkGrayMain)
                                            )
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 10)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                Button(action: {
                                    selectedCategory = nil
                                }) {
                                    Text("All Categories")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(selectedCategory == nil ? .backgroundMain : .titleGrayMain)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(selectedCategory == nil ? .gradientBlue : .surfaceGray)
                                        )
                                }
                                
                                ForEach(TaskCategory.allCases, id: \.self) { category in
                                    Button(action: {
                                        selectedCategory = category
                                    }) {
                                        Text(category.rawValue)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(selectedCategory == category ? .backgroundMain : .titleGrayMain)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(
                                                RoundedRectangle(cornerRadius: 15)
                                                    .fill(selectedCategory == category ? category.color : .darkGrayMain)
                                            )
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 10)
                        LazyVStack(spacing: 12) {
                            ForEach(filteredTasks) { task in
                                NavigationLink {
                                    EditTaskView(task: task)
                                } label: {
                                    TaskPreviewView(task: task)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, getSafeAreaTop() + 100)
                    .padding(.bottom, getSafeAreaBottom() + 200)
                }
            }
            NavigationLink {
                EditTaskView()
            } label: {
                Text("+ Add Task")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .colorFramed(color: .gradientBlue)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.horizontal, 20)
            .padding(.bottom, getSafeAreaBottom() + 120)
        }
        .customHeader(title: "Tasks", image: Image(systemName: "checklist"))
    }
}

#Preview {
    NavigationStack {
        TasksView()
            .environmentObject(UserService())
            .preferredColorScheme(.dark)
    }
}
