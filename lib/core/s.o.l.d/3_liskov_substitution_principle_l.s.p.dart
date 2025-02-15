// • Advanced Example:
// Consider a scenario where you have different types of accounts,
// such as a basic account and a premium account,
// and both can have different interest calculation logic.

// Bad example: Subclasses break the expectations set by the base class.
class AccountBad {
  double balance;

  AccountBad(this.balance);

  void withdraw(double amount) {
    if (amount > balance) {
      throw Exception('Insufficient funds');
    }
    balance -= amount;
  }
}

class PremiumAccountBad extends Account {
  PremiumAccountBad(super.balance);

  @override
  void withdraw(double amount) {
    // Premium accounts allow overdraft, violating LSP since it changes behavior
    balance -= amount;
  }
}

// Good example: Subclasses preserve the base class behavior while extending it.
abstract class Account {
  double balance;

  Account(this.balance);

  void withdraw(double amount);
}

class BasicAccount extends Account {
  BasicAccount(super.balance);

  @override
  void withdraw(double amount) {
    if (amount > balance) {
      throw Exception('Insufficient funds');
    }
    balance -= amount;
  }
}

class PremiumAccount extends Account {
  double overdraftLimit;

  PremiumAccount(super.balance, this.overdraftLimit);

  @override
  void withdraw(double amount) {
    if (amount > balance + overdraftLimit) {
      throw Exception('Overdraft limit exceeded');
    }
    balance -= amount;
  }
}


	// • Why is this better?:
  // Both BasicAccount and PremiumAccount behave as expected
  // without altering the fundamental rules of withdrawal behavior,
  // respecting the LSP.