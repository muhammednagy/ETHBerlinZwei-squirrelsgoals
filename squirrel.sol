pragma solidity ^0.5.1;

/* 
@title squirrel
@author Muhammed Nagy <me@muhnagy.com>
*/

contract squirrel {
    struct goal {uint256 target ; uint256 balance;}
    
    mapping (address => goal)  goals;

    function createGoal(uint256 target) public returns (bool) {
        goals[msg.sender].target = target;
        return true;
    }
    
    function makePayment() payable public  returns (uint256) {
        goals[msg.sender].balance += msg.value;
        if (goals[msg.sender].balance >= goals[msg.sender].target) {
                msg.sender.transfer(goals[msg.sender].balance);
                goals[msg.sender].balance = 0;
        }
        return goals[msg.sender].balance;
    } 
    
    function getInfo() public view returns (uint256, uint256){
        return (goals[msg.sender].target, goals[msg.sender].balance); 
    }
    
}
