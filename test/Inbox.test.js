const assert = require('assert');
const ganache= require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
const {interface, bytecode} = require('../compile');

let accounts;
let inbox;

beforeEach(async () =>{
  //getting the list of the accounts and deploy the contract with one of the accounts among them.
  accounts = await web3.eth.getAccounts();
 inbox = await new web3.eth.Contract(JSON.parse(interface))
  .deploy({data: bytecode,arguments: ['Hello there!']})
  .send({from: accounts[0],gas: '1000000'});

});

describe('Inbox',()=>{
  it('Deploying a contract',()=>{
    //console.log(inbox);
    assert.ok(inbox.options.address);
  });
  it('has a default value',async()=>{
    const message = await inbox.methods.message().call();
    assert.equal(message,'Hi there!');
  });
});



//We will use the async/await method instead of using .then stuff
/*beforeEach(() =>{
  web3.eth.getAccounts()
  .then(Accounts =>{
    console.log(Accounts);
  });
});

describe('Inbox',()=>{
  it('Deploying',()=>{});
});*/





/*
class Car {
  park(){
    return 'stopped';
  }
  drive(){
    return 'vroom';
  }
}

let car;//We might have used const if the value of the variable car is not changing
beforeEach(()=>{
   car = new Car();

})
describe('car', () =>{
  it('can park',() => {
    assert.equal(car.park(),'stopped');
  });
  it('Now we can drive',()=>{
    assert.equal(car.drive(),'vroom');
  });
});*/
