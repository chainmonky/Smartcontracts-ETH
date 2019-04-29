pragma solidity ^0.4.25;
contract Maxsupply{
    string public message;
     constructor(string newMessage) public{
        message = newMessage;
    }
    function setmessage(string _message) public{
        message = _message;
    }
}
