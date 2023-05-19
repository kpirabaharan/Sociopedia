# Social Media Full-Stack Application

This is a full-stack social media application that includes both a web and mobile version. It allows users to connect and share content with others. The application provides features such as user registration, authentication, posting, commenting, liking, and following other users. The technologies used for each version are as follows:

## Web Application

### Technologies Used

- **Front-end**: React.js, HTML, CSS, JavaScript
- **Back-end**: Node.js, Express.js
- **Database**: MongoDB
- **Authentication**: JSON Web Tokens (JWT)

## Mobile Application

### Technologies Used

- **Framework**: Flutter
- **Language**: Dart
- **Authentication**: JSON Web Tokens (JWT)
- **Database**: MongoDB
- **API Integration**: RESTful APIs

## Common Features

- User registration and login: Users can create an account and log in to the application.
- Posting: Users can create and publish posts with text, images, or videos.
- Commenting: Users can leave comments on posts.
- Liking: Users can like posts.
- Following: Users can follow other users to see their posts on their feed.
- User profiles: Each user has a profile page displaying their information and posts.
- Search functionality: Users can search for other users or posts.
- Newsfeed: Users see a personalized newsfeed displaying posts from the users they follow.
- Notifications: Users receive notifications for new comments, likes, and followers.

## Installation

To set up the application:

1. Clone the repository: `git clone https://github.com/your-username/social-media-app.git`
2. Set up the web application:
   - Navigate to the web application directory: `cd social-media-app/web`
   - Install the dependencies: `npm install`
3. Set up the mobile application:
   - Navigate to the mobile application directory: `cd social-media-app/mobile`
   - Install the dependencies: `flutter pub get`
4. Set up the database connection: Create a MongoDB Atlas account and obtain the connection URI. Replace the appropriate connection URI value in both the web and mobile application code files.
5. Start the web application:
   - Navigate to the web application directory: `cd social-media-app/web`
   - Start the server: `npm start`
   - Access the web application at: `http://localhost:3000`
6. Start the mobile application:
   - Navigate to the mobile application directory: `cd social-media-app/mobile`
   - Start the application: `flutter run`

## Deployment

To deploy the application:

1. Deploy the web application:
   - Build the web application: `cd social-media-app/web && npm run build`
   - Deploy the build files to your preferred hosting platform (e.g., Heroku, Netlify, Vercel).
2. Deploy the mobile application:
   - Follow the relevant deployment guidelines for your target platforms (e.g., Android or iOS).

## Contributors

- [Keeshigan Pirabaharan](https://github.com/kpirabaharan/Sociopedia.git)

## License

This project is licensed under the MIT License Feel free to use, modify, and distribute the code as per the terms of the license.
