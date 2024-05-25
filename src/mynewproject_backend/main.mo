import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";

actor {
  type StudentAccount = {
    account : Bank;
    about : Student;
  };

  type Bank = {
    balance : Nat;
    withdrawAmount : Nat;
    depositAmount : Nat;
  };

  type Student = {
    name : Text;
    level : Int;
    matric : Int;
  };

  type StudentAccountType = [StudentAccount];

  let DEPOSIT_AMOUNT : Nat = 100;
  let WITHDRAW_AMOUNT : Nat = 50;

  // Function to handle deposit
  func deposit(account : Bank) : Bank {
    return {
      balance = account.balance + DEPOSIT_AMOUNT;
      withdrawAmount = account.withdrawAmount;
      depositAmount = account.depositAmount;
    };
  };

  // Function to handle withdrawal
  func withdraw(account : Bank) : Bank {
    if (account.balance >= WITHDRAW_AMOUNT) {
      return {
        balance = account.balance - WITHDRAW_AMOUNT;
        withdrawAmount = account.withdrawAmount;
        depositAmount = account.depositAmount;
      };
    } else {
      Debug.print("Insufficient balance");
      return account;
    };
  };

  public query func transaction(data : StudentAccountType) : async StudentAccountType {
    return Array.map<StudentAccount, StudentAccount>(
      data,
      func(sa : StudentAccount) : StudentAccount {
        let updatedAccount = deposit(sa.account);
        let finalAccount = withdraw(updatedAccount);
        return { account = finalAccount; about = sa.about };
      },
    );
  };
};
