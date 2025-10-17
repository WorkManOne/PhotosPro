import SwiftUI

struct EditPhotoSessionView: View {
    @EnvironmentObject var userService: UserService
    @Environment(\.dismiss) var dismiss
    
    @State private var photoSession: PhotoSessionModel
    @State private var newEquipment = ""
    @State private var newTeam = ""
    @State private var newModel = ""
    
    init(photoSession: PhotoSessionModel? = nil) {
        let initialPhotoSession = photoSession ?? PhotoSessionModel()
        _photoSession = State(initialValue: initialPhotoSession)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Basic Information")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        CustomTextField(title: "Title", text: $photoSession.title)
                        CustomTextField(title: "Description", text: $photoSession.description, isMultiline: true)
                        CustomTextField(title: "Concept", text: $photoSession.concept)
                        CustomTextField(title: "Mood", text: $photoSession.mood)
                        CustomTextField(title: "Location", text: $photoSession.location)
                        
                        HStack {
                            Text("Priority")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Priority", selection: $photoSession.priority) {
                                ForEach(SessionPriority.allCases, id: \.self) { priority in
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
                            Picker("Status", selection: $photoSession.status) {
                                ForEach(SessionStatus.allCases, id: \.self) { status in
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
                        DatePicker("Scheduled Date", selection: Binding(
                            get: { photoSession.scheduledDate ?? Date() },
                            set: { photoSession.scheduledDate = $0 }
                        ), displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .colorScheme(.dark)
                        .accentColor(.gradientBlue)
                        
                        HStack {
                            Text("Duration (hours)")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Stepper("\(photoSession.estimatedDuration)", value: $photoSession.estimatedDuration, in: 1...24)
                                .foregroundColor(.white)
                        }
                        
                        HStack {
                            Text("Budget")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            TextField("0", value: $photoSession.budget, format: .currency(code: "USD"))
                                .lightFramed(isBordered: true)
                                .keyboardType(.decimalPad)
                        }
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
                                        photoSession.equipment.append(newEquipment)
                                        newEquipment = ""
                                    }
                                }
                            
                            Button("Add") {
                                if !newEquipment.isEmpty {
                                    photoSession.equipment.append(newEquipment)
                                    newEquipment = ""
                                }
                            }
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gradientBlue)
                        }
                        
                        if !photoSession.equipment.isEmpty {
                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 8) {
                                ForEach(photoSession.equipment, id: \.self) { equipment in
                                    HStack {
                                        Text(equipment)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            photoSession.equipment.removeAll { $0 == equipment }
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
                                        photoSession.team.append(newTeam)
                                        newTeam = ""
                                    }
                                }
                            
                            Button("Add") {
                                if !newTeam.isEmpty {
                                    photoSession.team.append(newTeam)
                                    newTeam = ""
                                }
                            }
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gradientBlue)
                        }
                        
                        if !photoSession.team.isEmpty {
                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 8) {
                                ForEach(photoSession.team, id: \.self) { member in
                                    HStack {
                                        Text(member)
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            photoSession.team.removeAll { $0 == member }
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
                    Text("Settings")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Indoor/Outdoor")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Location", selection: $photoSession.indoorOutdoor) {
                                ForEach(IndoorOutdoor.allCases, id: \.self) { location in
                                    Text(location.rawValue).tag(location)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Lighting")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Lighting", selection: $photoSession.lighting) {
                                ForEach(LightingType.allCases, id: \.self) { lighting in
                                    Text(lighting.rawValue).tag(lighting)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        HStack {
                            Text("Style")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.titleGrayMain)
                            Spacer()
                            Picker("Style", selection: $photoSession.style) {
                                ForEach(PhotoStyle.allCases, id: \.self) { style in
                                    Text(style.rawValue).tag(style)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        Toggle("Weather Dependent", isOn: $photoSession.weatherDependency)
                            .toggleStyle(CustomToggleStyle())
                    }
                }
                .lightFramed()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Notes")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    CustomTextField(title: "Additional Notes", text: $photoSession.notes, isMultiline: true)
                }
                .lightFramed()
            }
            .padding(.horizontal, 20)
            .padding(.top, getSafeAreaTop() + 100)
            Button(action: {
                savePhotoSession()
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
        .customHeader(title: "Edit Photo Session", isDismiss: true)
    }
    
    private func savePhotoSession() {
        if let index = userService.photoSessions.firstIndex(where: { $0.id == photoSession.id }) {
            userService.photoSessions[index] = photoSession
        } else {
            userService.photoSessions.append(photoSession)
        }
    }
}

#Preview {
    NavigationStack {
        EditPhotoSessionView()
            .environmentObject(UserService())
            .preferredColorScheme(.dark)
    }
}
