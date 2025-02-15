// •	Advanced Example:
// Consider a user management system where users can register,
// be notified via email, and their activities are logged.

// Bad example: UserManager does too many things
import 'dart:developer';

class UserManagerBad {
  void registerUser(String username, String password) {
    // Registration logic (e.g., saving user to database)
    log("User registered");

    // Send notification
    log("Email sent to user");

    // Log activity
    log("User registration logged");
  }
}

// Good example: Each class has a specific responsibility
class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});
}

class UserManager {
  final EmailService emailService;
  final Logger logger;
  final UserRepository userRepository;

  UserManager(this.emailService, this.logger, this.userRepository);

  void registerUser(User user) {
    userRepository.saveUser(user);
    emailService.sendWelcomeEmail(user.name);
    logger.log("User registered: ${user.name}");
  }
}

class EmailService {
  void sendWelcomeEmail(String username) {
    // Email sending logic
    log("Email sent to $username");
  }
}

class Logger {
  void log(String message) {
    // Logging logic
    log("Log: $message");
  }
}

class UserRepository {
  void saveUser(User user) {
    // User saving logic (e.g., to a database)
    log("User saved: ${user.id}");
  }

  void updateUser(User user) {
    // User data updated logic (e.g., to a database)
    log("Update user: $user");
  }

  void deleteUser(User user) {
    // User data deleted logic (e.g., to a database)
    log("Delete user: $user");
  }
}


	// •	Why is this better?:
  // If you need to change the logging mechanism 
  // or switch to a different email service, 
  // you only modify the respective class without affecting the others.