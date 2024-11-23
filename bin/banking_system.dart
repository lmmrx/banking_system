import 'dart:io';

class Account {
  String name;
  double balance;

  Account(this.name, this.balance);

  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      print(
          'Deposited: \$${amount.toStringAsFixed(2)}. New Balance: \$${balance.toStringAsFixed(2)}');
    } else {
      print('Invalid deposit amount.');
    }
  }

  bool withdraw(double amount) {
    if (amount > 0 && amount <= balance) {
      balance -= amount;
      print(
          'Withdrew: \$${amount.toStringAsFixed(2)}. New Balance: \$${balance.toStringAsFixed(2)}');
      return true;
    }
    print('Insufficient Withdrawal Balance.');
    return false;
  }

  void display() {
    print('Account Holder: $name, Balance: \$${balance.toStringAsFixed(2)}');
  }
}

class BankingSystem {
  List<Account> accounts = [];

  void createAccount() {
    stdout.write('Enter Name: ');
    String name = stdin.readLineSync()!;
    accounts.add(Account(name, 0));
    print('Account created for $name.');
  }

  void deposit() {
    stdout.write('Enter Name: ');
    String name = stdin.readLineSync()!;
    Account? account = accounts.firstWhere((acc) => acc.name == name,
        orElse: () => Account('', 0));
    if (account.name.isNotEmpty) {
      stdout.write('Deposit Amount: ');
      String? input = stdin.readLineSync();
      double amount = double.tryParse(input ?? '') ?? 0.0;
      account.deposit(amount);
    } else {
      print('Account not found.');
    }
  }

  void withdraw() {
    stdout.write('Enter Name: ');
    String name = stdin.readLineSync()!;
    Account? account = accounts.firstWhere((acc) => acc.name == name,
        orElse: () => Account('', 0));
    if (account.name.isNotEmpty) {
      stdout.write('Withdrawal Amount: ');
      String? input = stdin.readLineSync();
      double amount = double.tryParse(input ?? '') ?? 0.0;
      account.withdraw(amount);
    } else {
      print('Account not found.');
    }
  }

  void displayAccounts() {
    if (accounts.isEmpty) {
      print('No account/s found.');
    } else {
      for (var account in accounts) {
        account.display();
      }
    }
  }

  void run() {
    while (true) {
      print('--- Banking System ---');
      print('1. Create Account');
      print('2. Deposit');
      print('3. Withdraw');
      print('4. Display Accounts');
      print('5. Exit');

      stdout.write('Select: ');
      String? choice = stdin.readLineSync();
      if (choice == '1') {
        createAccount();
      } else if (choice == '2') {
        deposit();
      } else if (choice == '3') {
        withdraw();
      } else if (choice == '4') {
        displayAccounts();
      } else if (choice == '5') {
        print('Exiting Banking System');
        break;
      } else {
        print('Invalid choice, try again.');
      }
    }
  }
}

void main() {
  BankingSystem().run();
}
