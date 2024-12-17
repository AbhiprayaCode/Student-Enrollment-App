# Student Enrollment App

This app is created to fulfill the requirements for the Wireless and Mobile Programming Final Exam. It is built using Flutter and Firebase Database.

## Data Structure

### 1. Students

The `students` collection represents the students in the system. Each student has the following fields:

- **id**: string (unique user ID)
- **name**: string
- **email**: string
- **password**: string (hashed for security)
- **enrollments**: array of objects, each containing:
    - **subject_name**: string
    - **credit_hours**: int

### 2. Subjects

The `subjects` collection represents the subjects in the system. Each subject has the following fields:

- **id**: string (unique subject ID)
- **name**: string
- **credit_hours**: int

---

## Features

- Students can enroll in multiple subjects.
- The app allows storing student details securely with encrypted passwords.
- The app also tracks the number of credit hours for each subject enrolled by the student.
- Data is stored in Firebase, ensuring real-time updates and scalability.

---

## Requirements

- Flutter
- Firebase Database

---

## Setup

To run this project locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/AbhiprayaCode/Student-Enrollment-App.git
