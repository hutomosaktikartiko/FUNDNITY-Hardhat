// SPDX-License-Identifier: MIT
pragma solidity ^0.4.17;

// Kemungkinan satu user bisa membuat banyak campaign
// Tidak cocok kalau menyimpan seluruh list campaign didalam mapping

contract Crowdfunding {
    address[] public campaigns;

    function createCampaign(string memory _image, string memory _title, string memory _description, uint _target, uint _endDate) public {
        address newCampaign = new Campaign(_image, _title, _description, _target, _endDate);
        campaigns.push(newCampaign);
    }

    function getCampaigns() public view returns (address[]) {
        return campaigns;
    }
}

contract Campaign {
    string public image;
    string public title;
    string public description;
    uint public balance;
    uint public target;
    uint public endDate;
    bool public isComplete;
    address public creatorAddress;
    Contribute[] public contributors;

    struct Contribute {
        uint amount;
        address contributor;
    }

    // constructor (string memory _image, string memory _title, string memory _description, uint _target, uint _endDate) payable {
    //     image = _image;
    //     title =  _title;
    //     description =  _description;
    //     target =  _target;
    //     startDate = block.timestamp;
    //     endDate = _endDate;
    //     creatorAddress =  msg.sender;
    // }

    modifier onlyCreator() {
        require (msg.sender == creatorAddress);
        _;
    }

    function Campaign(string memory _image, string memory _title, string memory _description, uint _target, uint _endDate) public {
        image = _image;
        title =  _title;
        description =  _description;
        target =  _target;
        endDate = _endDate;
        creatorAddress =  msg.sender;
    }

    // TODO: Add message
    function contribute() public payable {
        require(isComplete == false);
        require(endDate <= now);
        require(msg.value > 0);

        Contribute memory newContribute = Contribute({
            amount: msg.value,
            contributor: msg.sender
        });

        contributors.push(newContribute);
        balance += msg.value;
    }

    function deliverBalance(uint _value) onlyCreator public payable {
        require(balance > 0);
        require(_value > 0);

        creatorAddress.transfer(_value);
        isComplete = true;
    }
    
    function getCampaign() public view returns (string memory, string memory, string memory, uint, uint, uint, uint, bool, address, address) {
        return (
            image,
            title,
            description,
            balance,
            target,
            block.timestamp,
            endDate,
            isComplete,
            creatorAddress,
            address(this)
        );
    }

    function getContributors() public view returns (address[] memory, uint[] memory) {
        address[] memory contributorsAddress = new address[](contributors.length);
        uint[] memory contributorsAmount = new uint[](contributors.length);

        for (uint i = 0; i < contributors.length; i++) {
            contributorsAddress[i] = contributors[i].contributor;
            contributorsAmount[i] = contributors[i].amount;
        }

        return (
            contributorsAddress,
            contributorsAmount
        );
    }
}