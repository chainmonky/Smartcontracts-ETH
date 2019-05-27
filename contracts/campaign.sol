pragma solidity ^0.4.17;
 contract campaignFactory{
      address[] public deployedCampaigns;
      function createCampaign(uint mincontri) public{
         address newCampaign = new Campaign(mincontri,msg.sender);
         deployedCampaigns.push(newCampaign);
      }
      function getDeployedCampaigns() public view returns(address[]){
          deployedCampaigns;
      }
   }


contract Campaign{

    struct Request{
        string description;
        uint value;
        address recepient;
        bool complete;
        uint voteCount;
        mapping(address => bool) approvals;
    }

    address public manager;
    uint public minimumContribution;
    mapping(address => bool) public approvers;
    Request[] public requests;
    uint public approversCount;


    modifier restricted(){
       require(msg.sender==manager);
        _;
    }
    function Campaign(uint mincontri,address creator) public{
        minimumContribution = mincontri;
        manager = creator;
    }

    function contribute() public payable{
        require(msg.value > minimumContribution);
        approvers[msg.sender] = true;
        approversCount++;

    }

    function createRequest(string description,uint value,address recepient) public restricted{
        Request memory newRequest = Request({
            description : description,
            value : value,
            recepient :recepient,
            complete : false,
            voteCount :0
        });
        requests.push(newRequest);
    }

    function approveRequest(uint index) public{
        //checking the approver has donated to the campaign.
        require(approvers[msg.sender]);
        //checking the approval can be only done only once for a particular request.
        require(!requests[index].approvals[msg.sender]);

        requests[index].approvals[msg.sender] = true;
        requests[index].voteCount++;

    }
    function finalizeRequest(uint index) public restricted{
        require(!requests[index].complete);
        require(requests[index].voteCount > (approversCount/2));
        requests[index].recepient.transfer(requests[index].value);
        requests[index].complete =true;
    }

}
