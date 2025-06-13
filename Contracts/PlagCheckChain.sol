// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract PlagCheckChain {
    struct Submission {
        address student;
        string assignmentName;
        bytes32 codeHash;
        uint256 timestamp;
    }

    Submission[] public submissions;

    event CodeSubmitted(address indexed student, string assignmentName, bytes32 codeHash, uint256 timestamp);

    function submitCode(string memory assignmentName, string memory code) public {
        bytes32 hash = keccak256(abi.encodePacked(code));
        submissions.push(Submission(msg.sender, assignmentName, hash, block.timestamp));
        emit CodeSubmitted(msg.sender, assignmentName, hash, block.timestamp);
    }

    function getAllSubmissions() public view returns (Submission[] memory) {
        return submissions;
    }

    function checkIfDuplicate(bytes32 codeHash) public view returns (bool) {
        for (uint i = 0; i < submissions.length; i++) {
            if (submissions[i].codeHash == codeHash) {
                return true;
            }
        }
        return false;
    }
}
