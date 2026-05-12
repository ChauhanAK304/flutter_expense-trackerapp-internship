# Expense Tracker - Professional Internship Project

A full-featured financial management application built with **Flutter**. This project was developed during my internship to provide users with a seamless way to track income and expenses, visualize financial data, and sync records across devices in real-time.

##  Detailed Screen Breakdown & Functionality

This app is designed with a user-centric approach, ensuring each screen serves a specific logical purpose:

* **Authentication Flow (Login/Signup):** * Integrated **Firebase Auth** for secure access.
    * Features Email/Password login and **Google Sign-In**.
    * Includes form validation logic and password visibility toggles for a better UX.
* **Dashboard (Home Screen):** * The primary overview screen showing **Total Balance, Total Income, and Total Expenses**.
    * Displays a "Recent Transactions" list using `ListView.builder` for efficient rendering.
* **Add Transaction Screen:** * A clean form to input amount, title, and date.
    * **Category Selection:** Users can tag expenses (e.g., Food, Travel, Rent).
    * Logic implemented to automatically clear controllers and reset state after a successful entry.
* **Analytics & Statistics:** * Uses **fl_chart** to provide visual insights.
    * **Pie Charts** for category-wise distribution and **Bar Charts** for weekly/monthly comparisons.
* **Transaction History:** * A detailed list of all records with filtering capabilities.
    * Implemented "Delete on Swipe" or long-press actions for record management.
* **Settings & Profile:** * User profile management and secure logout.
    * **Theme Toggle:** Switch between Dark and Light modes instantly.

##  State Management Architecture

The project uses a hybrid state management strategy to balance performance and scalability:

### 1. Provider (Business Logic & Data Flow)
* **AuthProvider:** Handles the global user session, ensuring the app knows whether a user is logged in or out across all screens.
* **ExpenseProvider:** This is the heart of the app. It manages the list of transactions, calculates totals in real-time, and communicates with Firestore. I used `notifyListeners()` to ensure the UI reflects data changes immediately without manual refreshes.

### 2. GetX (Utility & UI State)
* **Theme Management:** Used GetX to handle theme switching (`Get.changeTheme`) because it doesn't require BuildContext, making it faster and cleaner.
* **Navigation:** Simplified routing and snackbars (notifications) using GetX to avoid boilerplate code.
* **Local UI Logic:** Managing simple states like loading spinners and password field toggles.

##  Backend & Technical Stack

* **Frontend:** Flutter (Dart) - leveraging `MediaQuery` and `LayoutBuilder` for a **fully responsive UI** that works on all screen sizes.
* **Database:** **Cloud Firestore** for real-time NoSQL data storage.
* **Authentication:** Firebase Auth (Email/Google).
* **State Management:** Provider + GetX.
* **Advanced Logic:** * Custom Exception Handling (e.g., handling null check operators).
    * Asynchronous programming using `Future` and `Stream` for real-time data flow.

##  Installation & Setup

1. **Clone the repo:**
   ```bash
   git clone [https://github.com/ChauhanAK304/flutter_expense-trackerapp-internship.git](https://github.com/ChauhanAK304/flutter_expense-trackerapp-internship.git)
   
2. **Install packages:**
   ```bash
    flutter pub get
3. **Firebase Configuration:**
    * Add your `google-services.json` to the `android/app` folder.
    * Enable Firestore and Authentication in your Firebase Console.
4. **Run the app:**
   ```bash
   flutter run
   
##  Project Structure

```text
lib/
├── models/         # Data blueprints (Expense, User)
├── providers/      # Main logic and state (Provider)
├── screens/        # UI Layers (Auth, Dashboard, Stats)
├── services/       # Firebase & Database interaction
├── utils/          # Constants, Themes, and Helpers
└── widgets/        # Reusable UI components (Custom Cards, Buttons)