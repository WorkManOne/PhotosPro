import SwiftUI

struct TaskPreviewView: View {
    let task: TaskModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    if !task.description.isEmpty {
                        Text(task.description)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(task.priority.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.backgroundMain)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(task.priority.color)
                        )
                    
                    Text(task.status.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.backgroundMain)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(task.status.color)
                        )
                }
            }
            VStack(alignment: .leading, spacing: 6) {
                if let clientName = task.clientName {
                    HStack {
                        Image(systemName: "person")
                            .font(.system(size: 12))
                            .foregroundColor(.titleGrayMain)
                            .frame(width: 16)
                        Text("Client: \(clientName)")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .lineLimit(1)
                    }
                }
                
                if let projectName = task.projectName {
                    HStack {
                        Image(systemName: "folder")
                            .font(.system(size: 12))
                            .foregroundColor(.titleGrayMain)
                            .frame(width: 16)
                        Text("Project: \(projectName)")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .lineLimit(1)
                    }
                }
                
                if let location = task.location {
                    HStack {
                        Image(systemName: "location")
                            .font(.system(size: 12))
                            .foregroundColor(.titleGrayMain)
                            .frame(width: 16)
                        Text(location)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.textGrayMain)
                            .lineLimit(1)
                    }
                }
            }
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    if let dueDate = task.dueDate {
                        HStack {
                            Image(systemName: "calendar")
                                .font(.system(size: 12))
                                .foregroundColor(.titleGrayMain)
                            Text("Due: \(dueDate, style: .date)")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.textGrayMain)
                        }
                    }
                    
                    HStack {
                        Image(systemName: "clock")
                            .font(.system(size: 12))
                            .foregroundColor(.titleGrayMain)
                        Text("Est: \(task.estimatedDuration) min")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.textGrayMain)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text(task.category.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.titleGrayMain)
                }
            }
            if !task.equipment.isEmpty || !task.team.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    if !task.equipment.isEmpty {
                        HStack {
                            Text("Equipment:")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Text(task.equipment.joined(separator: ", "))
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.textGrayMain)
                                .lineLimit(1)
                        }
                    }
                    
                    if !task.team.isEmpty {
                        HStack {
                            Text("Team:")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Text(task.team.joined(separator: ", "))
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.textGrayMain)
                                .lineLimit(1)
                        }
                    }
                }
            }
            
            if !task.tags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(task.tags, id: \.self) { tag in
                            Text("#\(tag)")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.gradientBlue)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(.gradientBlue.opacity(0.2))
                                )
                        }
                    }
                    .padding(.horizontal, 1)
                }
            }
        }
        .lightFramed()
    }
}

#Preview {
    TaskPreviewView(task: TaskModel(
        title: "Edit Wedding Photos",
        description: "Post-process 200 wedding photos for Sarah & John",
        category: .editing,
        priority: .high,
        status: .inProgress,
        dueDate: Date().addingTimeInterval(86400 * 3),
        estimatedDuration: 480,
        clientName: "Sarah & John",
        projectName: "Wedding Photography",
        equipment: ["MacBook Pro", "Lightroom", "Photoshop"],
        team: ["Assistant: Mike"],
        tags: ["wedding", "editing", "urgent"]
    ))
    .padding()
    .background(.backgroundMain)
    .preferredColorScheme(.dark)
}
