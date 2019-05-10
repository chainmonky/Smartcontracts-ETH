pragma solidity ^0.4.17;

contract Test{
    uint[] public myArray;
    function Test() public{
        myArray.push(1);
        myArray.push(2);
        myArray.push(3);
    }

    function getArray()public view returns(uint[]){
        return myArray;
    }

    function getArrayLength() public view returns(uint){
        return myArray.length;
    }
    function getElementArray()public view returns(uint){
        return myArray[1];
    }
}
