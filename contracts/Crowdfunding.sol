// SPDX-License-Identifier: MIT
pragma solidity ^0.4.17;

contract Crowdfunding {
    address[] public campaigns;

    event CampaignCreated(
        address indexed creatorAddress,
        address indexed campaignAddress,
        string campaignTitle,
        uint256 campaignTarget,
        uint256 campaignEndDate
    );

    function createCampaign(
        string memory _image,
        string memory _title,
        string memory _description,
        uint256 _target,
        uint256 _endDate
    ) public {
        require(_target > 0);

        address newCampaign = new Campaign(
            _image,
            _title,
            _description,
            _target,
            _endDate,
            msg.sender
        );
        campaigns.push(newCampaign);

        CampaignCreated(msg.sender, newCampaign, _title, _target, _endDate);
    }

    function getCampaigns() public view returns (address[]) {
        return campaigns;
    }
}

contract Campaign {
    string public image;
    string public title;
    string public description;
    uint256 public balance;
    uint256 public target;
    uint256 public endDate;
    bool public isComplete;
    address public creatorAddress;
    Contribute[] public contributors;

    // event
    event ContributionMade(
        address indexed campaignAddress,
        address indexed contributorAddress,
        uint256 amount
    );
    event CampaignCompleted(address indexed campaignAddress, uint256 amount);

    struct Contribute {
        uint256 amount;
        address contributor;
    }

    modifier onlyCreator() {
        require(msg.sender == creatorAddress);
        _;
    }

    function Campaign(
        string memory _image,
        string memory _title,
        string memory _description,
        uint256 _target,
        uint256 _endDate,
        address _creatorAddress
    ) public {
        image = _image;
        title = _title;
        description = _description;
        target = _target;
        endDate = _endDate;
        creatorAddress = _creatorAddress;
    }

    function contribute() public payable {
        require(isComplete == false);
        require(now <= endDate);
        require(msg.value > 0);
        require(balance < target);

        Contribute memory newContribute = Contribute({
            amount: msg.value,
            contributor: msg.sender
        });

        contributors.push(newContribute);
        balance += msg.value;

        ContributionMade(address(this), msg.sender, msg.value);
    }

    function deliverBalance() public payable onlyCreator {
        require(isComplete == false);
        require(balance > 0);

        creatorAddress.transfer(balance);
        isComplete = true;

        CampaignCompleted(address(this), balance);
    }

    function getCampaign()
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            uint,
            uint,
            uint,
            uint,
            bool,
            address,
            address,
            uint
        )
    {
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
            address(this),
            block.number
        );
    }

    function getContributors()
        public
        view
        returns (address[] memory, uint256[] memory)
    {
        address[] memory contributorsAddress = new address[](
            contributors.length
        );
        uint256[] memory contributorsAmount = new uint256[](
            contributors.length
        );

        for (uint256 i = 0; i < contributors.length; i++) {
            contributorsAddress[i] = contributors[i].contributor;
            contributorsAmount[i] = contributors[i].amount;
        }

        return (contributorsAddress, contributorsAmount);
    }
}
