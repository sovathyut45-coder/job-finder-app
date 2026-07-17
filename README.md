# 💼 Job Finder App

A modern **Job Finder Application** built with **Flutter** and **GetX**, featuring a clean architecture, Laravel REST API integration, authentication, job search, saved jobs, application tracking, and profile management.

---

## ✨ Features

### 🔍 Job Discovery
- Search jobs with debounce
- Popular job categories
- Job detail screen
- Recent viewed jobs
- Infinite scrolling (Pagination)
- Pull-to-refresh

### 👤 User Account
- User authentication (Login & Register)
- Profile management
- Avatar upload
- Change password

### 📄 Job Management
- Save/Unsave jobs
- Apply for jobs
- Track application status
- Add notes to applications
- Recent viewed jobs history

### 📊 Dashboard
- Applied jobs
- Interview invitations
- Accepted jobs
- Rejected jobs
- Saved jobs
- Recent viewed jobs

### 🎨 UI / UX
- Responsive design
- Light & Dark Theme
- Skeleton loading
- Error handling
- Internationalization (English & Khmer)

---

# 🏗 Project Structure

```text
lib/
│
├── core/
│   ├── network/
│   ├── routes/
│   ├── service/
│   ├── theme/
│   ├── translations/
│   └── widgets/
│
├── data/
│   ├── datasource/
│   ├── model/
│   └── repository/
│
├── modules/
│   ├── auth/
│   ├── dashboard/
│   ├── home/
│   ├── search/
│   ├── job_detail/
│   ├── apply_job/
│   ├── save_job/
│   ├── profile/
│   ├── settings/
│   └── recent_job/
│
├── initialBinding/
│
└── main.dart
```

---

# ⚙️ Tech Stack

### Framework

- Flutter
- Dart

### State Management

- GetX

### Networking

- Dio

### Local Storage

- GetStorage

### Backend

- Laravel REST API

### Database

- MySQL

### Image Handling

- Image Picker

### Architecture

- Repository Pattern
- GetX Bindings
- Clean Architecture

---

# 📦 Packages

- get
- dio
- get_storage
- cached_network_image
- shimmer
- skeletonizer
- flutter_html
- file_picker
- image_picker
- share_plus
- url_launcher
- intl

---

# 🚀 Getting Started

## Clone the repository

```bash
git clone https://github.com/sovathyut45-coder/job-finder-app.git
```

## Navigate to the project

```bash
cd job-finder-app
```

## Install dependencies

```bash
flutter pub get
```

## Run the application

```bash
flutter run
```

---

# 📂 Features Checklist

## Authentication

- [x] Login
- [x] Register
- [x] Logout
- [x] Change Password

## Jobs

- [x] Search Jobs
- [x] Pagination
- [x] Pull To Refresh
- [x] Job Detail
- [x] Save Jobs
- [x] Apply Job
- [x] Application Tracking
- [x] Recent Viewed Jobs

## Dashboard

- [x] Statistics
- [x] Application Status
- [x] Saved Jobs Count

## Profile

- [x] Update Profile
- [x] Upload Avatar

## UI

- [x] Dark Mode
- [x] Skeleton Loading
- [x] Localization (EN / KM)

---

# 🔮 Future Improvements

- Job recommendations
- Advanced filters
- Push notifications
- Resume builder
- Company reviews
- Offline support
- Email verification
- Social login
- Bookmark folders

---

# 👨‍💻 Author

**Phai Sovathyut**

🎓 Computer Science Student — Royal University of Phnom Penh (RUPP)

- 📧 Email: sovathyut45@gmail.com
- 💻 GitHub: https://github.com/sovathyut45-coder

---

# 📄 License

This project is developed for educational purposes and portfolio demonstration.