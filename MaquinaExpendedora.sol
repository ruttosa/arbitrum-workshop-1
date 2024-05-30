//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract MaquinaExpendedora {
    // state variables = internal memory of the vending machine
    mapping(address => uint) private _cupcakeBalances;
    mapping(address => uint) private _cupcakeDistributionTimes;

    function giveCupcakeTo(address userAddress) public returns (bool) {
        // Rule 1: The vending machine will distribute a cupcake to anyone who hasn't recently received one.
        uint fiveSecondsFromLastDistribution = _cupcakeDistributionTimes[userAddress] + 5 seconds;
        bool userCanReceiveCupcake = fiveSecondsFromLastDistribution <= block.timestamp;

        if (userCanReceiveCupcake) {
            _cupcakeBalances[userAddress]++;
            _cupcakeDistributionTimes[userAddress] = block.timestamp;
            return true;
        } else {
            revert("HTTP 429: Too Many Cupcakes (you must wait at least 5 seconds between cupcakes)");
        }
    }

     // Getter function for the cupcake balance of a user
    function getCupcakeBalanceFor(address userAddress) public view returns (uint) {
        return _cupcakeBalances[userAddress];
    }
}