pragma solidity ^0.4.2;

contract Election {

    struct Candidate {
        string name;
        uint voteCount;
    }

    struct Voter {
        bool voted;
        uint vote;
        uint weight;
    }

    string public name;
    address public owner;
    mapping(address => Voter) public voters;
    Candidate[] public candidates;

    event ElectionResult(string name, uint voteCount);

    function Election(string _name, string name1, string name2) public {
        owner = msg.sender;
        name = _name;

        candidates.push(Candidate({name: name1, voteCount: 0}));
        candidates.push(Candidate({name: name2, voteCount: 0}));
    }

    function authorize(address voter) public {

        require(msg.sender == owner);
        require(!voters[voter].voted);

        voters[voter].weight = 1;
    }

    function vote(uint voteIndex) public {
        require(!voters[msg.sender].voted);

        voters[msg.sender].vote = voteIndex;
        voters[msg.sender].voted = true;

        candidates[voteIndex].voteCount += voters[msg.sender].weight;
    }

    function end() public {
        require(msg.sender == owner);

        for(uint i=0; i < candidates.length; i++) {
            ElectionResult(candidates[i].name, candidates[i].voteCount);
        }

        //any future ether sent to this address will be lost, alt = keep on chain and maintain internal state
        selfdestruct(owner);

    }
}
