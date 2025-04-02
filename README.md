Employee Task is a Flutter application for managing employee data using Hive for local storage and BLoC for state management. The app allows users to add, edit, and delete employees, with role selection and date pickers for joining and ending dates

Features
    Add, edit, and delete employee data
    Role selection (Designer, Developer, Tester, Owner)
    Joining date and ending date selection
    Uses Hive for local database storage
    BLoC for state management

Requirements
Flutter SDK : 3.29.2

Installation
1.  Clone the repository:
git clone https://github.com/SartilaGajera/employee_task.git
2.  Navigate to the project directory:
cd employee_task
3.  Install dependencies:
flutter pub get
4.  Run the app:
flutter run

Usage
Upon launching the app, you'll be presented with list of employee data.
Tap on employee card navigate to edit page to edit data
Tap on a plus button add new employee
Tap on a save to save employee data
Swipe left to delete that employee data

State Management
This app uses BLOC for state management, which provides a simple and efficient way to manage state and update UI components.