import SwiftUI

struct EditTaskView: View {
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    
    @State private var task: TaskModel
    @State private var newEquipment = ""
    @State private var newTeam = ""
    @State private var newTag = ""
    
    init(task: TaskModel? = nil) {
        _task = State(initialValue: task ?? TaskModel())
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Basic Information")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        CustomTextField(title: "Title", text: $task.title)
                        CustomTextField(title: "Description", text: $task.description, isMultiline: true)
                        
                        HStack {
                            Text("Category")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Category", selection: $task.category) {
                                ForEach(TaskCategory.allCases, id: \.self) { category in
                                    Text(category.rawValue).tag(category)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Priority")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Priority", selection: $task.priority) {
                                ForEach(TaskPriority.allCases, id: \.self) { priority in
                                    Text(priority.rawValue).tag(priority)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Status")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Status", selection: $task.status) {
                                ForEach(TaskStatus.allCases, id: \.self) { status in
                                    Text(status.rawValue).tag(status)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Scheduling")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        DatePicker("Due Date", selection: Binding(
                            get: { task.dueDate ?? Date() },
                            set: { task.dueDate = $0 }
                        ), displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .colorScheme(.dark)
                        .accentColor(.gradientBlue)

                        HStack {
                            Text("Estimated Duration (minutes)")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Stepper("\(task.estimatedDuration)", value: $task.estimatedDuration, in: 15...480)
                                .foregroundColor(.white)
                        }
                        
                        HStack {
                            Text("Actual Duration (minutes)")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            TextField("0", value: Binding(
                                get: { task.actualDuration ?? 0 },
                                set: { task.actualDuration = $0 == 0 ? nil : $0 }
                            ), format: .number)
                                .keyboardType(.numberPad)
                                .lightFramed(isBordered: true)
                        }
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Project Information")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        CustomTextField(title: "Client Name", text: Binding(
                            get: { task.clientName ?? "" },
                            set: { task.clientName = $0.isEmpty ? nil : $0 }
                        ))
                        CustomTextField(title: "Project Name", text: Binding(
                            get: { task.projectName ?? "" },
                            set: { task.projectName = $0.isEmpty ? nil : $0 }
                        ))
                        CustomTextField(title: "Location", text: Binding(
                            get: { task.location ?? "" },
                            set: { task.location = $0.isEmpty ? nil : $0 }
                        ))
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Equipment & Team")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        HStack {
                            TextField("Add equipment", text: $newEquipment)
                                .lightFramed(isBordered: true)
                                .onSubmit {
                                    if !newEquipment.isEmpty {
                                        task.equipment.append(newEquipment)
                                        newEquipment = ""
                                    }
                                }
                            
                            Button("Add") {
                                if !newEquipment.isEmpty {
                                    task.equipment.append(newEquipment)
                                    newEquipment = ""
                                }
                            }
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gradientBlue)
                        }
                        
                        if !task.equipment.isEmpty {
                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 8) {
                                ForEach(task.equipment, id: \.self) { equipment in
                                    HStack {
                                        Text(equipment)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            task.equipment.removeAll { $0 == equipment }
                                        }) {
                                            Image(systemName: "xmark")
                                                .font(.system(size: 10))
                                                .foregroundColor(.red)
                                        }
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(.surfaceGray)
                                    )
                                }
                            }
                        }
                        HStack {
                            TextField("Add team member", text: $newTeam)
                                .lightFramed(isBordered: true)
                                .onSubmit {
                                    if !newTeam.isEmpty {
                                        task.team.append(newTeam)
                                        newTeam = ""
                                    }
                                }
                            
                            Button("Add") {
                                if !newTeam.isEmpty {
                                    task.team.append(newTeam)
                                    newTeam = ""
                                }
                            }
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gradientBlue)
                        }
                        
                        if !task.team.isEmpty {
                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 8) {
                                ForEach(task.team, id: \.self) { member in
                                    HStack {
                                        Text(member)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            task.team.removeAll { $0 == member }
                                        }) {
                                            Image(systemName: "xmark")
                                                .font(.system(size: 10))
                                                .foregroundColor(.red)
                                        }
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(.surfaceGray)
                                    )
                                }
                            }
                        }
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Tags")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        HStack {
                            TextField("Add tag", text: $newTag)
                                .lightFramed(isBordered: true)
                                .onSubmit {
                                    if !newTag.isEmpty {
                                        task.tags.append(newTag)
                                        newTag = ""
                                    }
                                }
                            
                            Button("Add") {
                                if !newTag.isEmpty {
                                    task.tags.append(newTag)
                                    newTag = ""
                                }
                            }
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gradientBlue)
                        }
                        
                        if !task.tags.isEmpty {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                                ForEach(task.tags, id: \.self) { tag in
                                    HStack {
                                        Text("#\(tag)")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.gradientBlue)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            task.tags.removeAll { $0 == tag }
                                        }) {
                                            Image(systemName: "xmark")
                                                .font(.system(size: 10))
                                                .foregroundColor(.red)
                                        }
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(.gradientBlue.opacity(0.2))
                                    )
                                }
                            }
                        }
                    }
                }
                .lightFramed()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Notes")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    CustomTextField(title: "Additional Notes", text: $task.notes, isMultiline: true)
                }
                .lightFramed()
            }
            .padding(.horizontal, 20)
            .padding(.top, getSafeAreaTop() + 100)
            
            Button(action: {
                saveTask()
                dismiss()
            }) {
                Text("Save")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .colorFramed(color: .gradientBlue)
            }
            .padding(.top, 10)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .customHeader(title: "Edit Task", isDismiss: true)
    }
    
    private func saveTask() {
        if let index = userService.tasks.firstIndex(where: { $0.id == task.id }) {
            userService.tasks[index] = task
        } else {
            userService.tasks.append(task)
        }
    }
}

#Preview {
    NavigationStack {
        EditTaskView()
            .environmentObject(UserService())
            .preferredColorScheme(.dark)
    }
}
