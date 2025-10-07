EventHub — SwiftUI Event Registration Form App

Overview
EventHub is a SwiftUI-based iOS application that allows users to register for a fictional event. It validates user inputs, saves registration data using Core Data, and displays a confirmation message upon successful submission. Every registration is logged to the Xcode console. The app also includes a list view of all saved registrations, fulfilling both core and bonus assignment requirements.

Technologies Used
- **SwiftUI** — Declarative user interface
- **Core Data** — Local data persistence (programmatic model setup)
- **MVVM Architecture** — Logical separation between UI and data
- **NavigationStack & TabView** — Modern navigation and tab management
- **Form / Picker / Stepper / Toggle / Alert** — User-friendly form inputs

Features
| Feature | Description |
|----------|--------------|
| 🧾 Registration Form | Collects user details |
| ⚠️ Validation Alerts | Displays when input is invalid |
| 💾 Core Data Persistence | Saves registrant info locally |
| ✅ Confirmation Screen | Displays registration summary |
| 📋 Registrants Tab | Lists all saved registrants |
| 🗑️ Swipe-to-Delete | Remove registrants from Core Data |
| 🕓 Timestamp Sorting | Sorts newest registrations first |
| 🧠 Console Logging | Structured print output for tracking |

How to Test Functionality
1. Submit empty form → expect alert.
2. Submit invalid email → expect alert.
3. Enter valid data → navigate to confirmation screen.
4. Check **console log** for registration info.
5. Switch to **Registrants** tab → see saved data.
6. Swipe left to delete entry → confirm removal.
7. Relaunch app → confirm persistence.

Expected Screens
1. **Register Tab:** Form with fields for name, email, age, gender, and student toggle.  
2. **Confirmation Screen:** Thank-you message and user details summary.  
3. **Registrants Tab:** List of all saved registrants, swipe-to-delete enabled.



