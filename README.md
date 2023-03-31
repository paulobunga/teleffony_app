# Teleffony

# Tech Stack Used

1. Flutter
2. Getx State management
3. Plugins

- url_launcher (For launching phone number dialpad)
- dotted_border (For adding styling around borders on widgets)
- get_storage (For storing categories and contact information)
- icons_launcher ( For building native app icon)
- fluttercontactspicker (For picking contact information from phone contacts)
- uuid (For generating unique ids for categories and contacts)

# Working Functionality ( The code that I have worked on)

1. Add Category
2. Add Category Dropdown Selector
3. Search functionality for added Categories
4. Selected category list
5. Add new category with image uploda
6. View Category detals .i.e Contact section
7. Add new contac
   a. Add contact from Form
   b. Add contact from Contact List after accepting permissions
   c. Add Social media handle
8. Delete contact
9. Store data locally to avoid losing saved information when app is restarted.

# Suggestions on improvement and enhancements.

1. Reduce on boilerplate code and reuse components for buttons and repetitive UI elements. Note: I had started working on a common UI components for Buttons, Forms, Modals, Text Input and styles but stopped because of time constraints
2. Create and execute unit and integration tests for the application widgets and functions. Due to time constraints I could not work on this as well.
3. Add croping functionality to limit the size of the image uploaded.
4. Add validation to form fields for phone number, links
5. Create a UI Theme to handle fonts and dark mode functionality
6. Add a backup service that stores the data on an online service like dropbox or google drive. That way a user can redownload their business information if it is deleted.
7. Add comments to functionality of the app to make it easier for the team to work with
8. Improve on layouts across devices using a general style guide.

# How to run the code

1. Clone the project and cd into directory

```
git clone https://
```

2. Install dependencies

```
cd teleffony_app
```

```
flutter pub get
```

3. Run on connected device or emulator

```shell
flutter run --hot
```

# Screenshots

<div style="display: flex; justify-content: center; gap: 20px; padding: 20px;">

<img src="https://user-images.githubusercontent.com/10288731/229138344-2f005ed2-7459-48c3-b68e-ed8fb7bac7e8.png" width="150">

<img src="https://user-images.githubusercontent.com/10288731/229138350-1fdd1b2b-770b-4af3-a820-23edfb9efd8c.png" width="150">

<img src="https://user-images.githubusercontent.com/10288731/229138361-e410149a-d75f-4182-b585-67be6d95141f.png" width="150">

<img src="https://user-images.githubusercontent.com/10288731/229138367-9297fb16-311b-4420-8ca1-0ca071046d16.png" width="150">
</div>
