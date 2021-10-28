pragma solidity >=0.8.7;
//SPDX-License-Identifier: UNLICENSED;
import "./carbonproject.sol";

contract CarbonTokenContract is CarbonProject{
    //Define token parameters
    struct CarbonToken {
        uint carbonProjectID;
        bool fungible;
        bool transferable;
        bool durability;
        uint totalTokenSupply;
        uint currentTokenSupply;
    }
    mapping(uint => address) tokenOwner;
    mapping (address => uint) tokensIssued;
    mapping (uint => uint) currentSupply;
    address private _tokenCreator;
    CarbonToken[] public carbonTokens;

    constructor() {
        //Only the contract creator can mint tokens
        _tokenCreator = msg.sender;
    }

    modifier isTokenCreator(address _userAddress){
        require(_userAddress == _tokenCreator);
        _;
    }

    function mintToken(uint _carbonProjectID, bool _fungible, bool _transferable, bool _durability) public isTokenCreator(msg.sender) {
        require(_carbonProjectID == ownedProjects[msg.sender]);
        uint _totalTokenSupply = projectCarbonCredits[_carbonProjectID];
        uint _currentTokenSupply = projectCarbonCredits[_carbonProjectID];
        carbonTokens.push(CarbonToken(_carbonProjectID, _fungible, _transferable, _durability, _totalTokenSupply, _currentTokenSupply));
        currentSupply[_carbonProjectID] = _currentTokenSupply;
    }

    function issueToken(address _newOwner, uint _numberOfTokens, uint _carbonProjectID) public isTokenCreator(msg.sender) {
        require(_carbonProjectID == ownedProjects[msg.sender]);
        uint current = currentSupply[_carbonProjectID];
        require(_numberOfTokens <= current);
        tokensIssued[_newOwner] = _numberOfTokens;
        current -= _numberOfTokens;
        currentSupply[_carbonProjectID] = current;
    }
}
