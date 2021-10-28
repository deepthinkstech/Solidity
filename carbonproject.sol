pragma solidity >=0.8.7;
//SPDX-License-Identifier: UNLICENSED

contract CarbonProject {
    //Define project parameters
    struct Project {
        //uint projectID;
        string projectName;
        string location;
        bool additionality;
        uint vintage;
        uint durability;
        bool leakage;
        uint tonCarbonSequestered;
        uint carbonCredits;
       // address projectOwner;
    }
    mapping (uint => address) projectOwner;
    mapping (uint => uint) projectCarbonCredits;
    mapping (address => uint) ownedProjects;


    //Define project instance
    Project[] public projectInfo;

    //Define function to capture project information
    function captureProjectInfo(string memory _projectName, string memory _location, bool _additionality, uint _vintage, uint _durability, bool _leakage, uint _tonCarbonSequestered) public returns (uint){
        //Calculate carbon credits
        uint carbonCredits = calculateCarbonCredits(_tonCarbonSequestered);
        projectInfo.push(Project(_projectName, _location, _additionality, _vintage, _durability, _leakage, _tonCarbonSequestered, carbonCredits));
        uint projectID = projectInfo.length + 1;
        projectOwner[projectID] = msg.sender;
        projectCarbonCredits[projectID] = carbonCredits;
        ownedProjects[msg.sender] = projectID;
        return projectID;
    }
    //Define function to calculate carbon credits
    function calculateCarbonCredits(uint _carbonSequestered) private pure returns (uint){
        if (_carbonSequestered > 1){
            return _carbonSequestered;
        } else {
            return 0;
        }
    }
}