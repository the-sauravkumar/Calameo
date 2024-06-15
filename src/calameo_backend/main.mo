import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Text "mo:base/Text";

actor MyMemeCoin {
    // Variable to count total supply
    var totalSupply: Nat = 0;

    // Variable to store the balances as a mutable map of Nats
    var balances: HashMap.HashMap<Text, Nat> = HashMap.HashMap<Text, Nat>(10, Text.equal, Text.hash);

    // Function to mint new tokens and assign to a specified address
    public func mint(to: Text, amount: Nat) : async () {
        if (amount > 0) {
            let currentBalance = switch (balances.get(to)) {
                case (?balance) balance;
                case null 0;
            };
            // Add the amount to the existing balance or create a new balance for the address
            balances.put(to, currentBalance + amount);

            // Add the amount to the total supply
            totalSupply += amount;
        };
    };

    // Function to transfer tokens from one address to another
    public func transfer(from: Text, to: Text, amount: Nat) : async Bool {
        let fromBalance = switch (balances.get(from)) {
            case (?balance) balance;
            case null 0;
        };

        // Check if the sender has enough tokens
        if (fromBalance >= amount) {
            let toBalance = switch (balances.get(to)) {
                case (?balance) balance;
                case null 0;
            };

            // Subtract the amount from the sender's balance
            balances.put(from, fromBalance - amount);

            // Add the amount to the recipient's balance
            balances.put(to, toBalance + amount);

            // Return true on successful transfer
            return true;
        };

        // Return false if the sender doesn't have enough tokens
        return false;
    };

    // Function to get the balance of an address
    public func balanceOf(owner: Text) : async Nat {
        return switch (balances.get(owner)) {
            case (?balance) balance;
            case null 0;
        };
    };

    // Function to get the total supply
    public func getTotalSupply() : async Nat {
        return totalSupply;
    };

    // Function to burn tokens from an address
    public func burn(from: Text, amount: Nat) : async Bool {
        let fromBalance = switch (balances.get(from)) {
            case (?balance) balance;
            case null 0;
        };

        // Check if the sender has enough tokens
        if (fromBalance >= amount) {
            // Subtract the amount from the sender's balance
            balances.put(from, fromBalance - amount);

            // Subtract the amount from the total supply
            totalSupply -= amount;

            // Return true on successful burn
            return true;
        };

        // Return false if the sender doesn't have enough tokens
        return false;
    };
};
