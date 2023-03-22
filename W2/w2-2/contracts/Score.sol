// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Score {

    //student score mapping
    mapping(address => uint8) scores;
    
    //Teacher address
    address public teacher;
    string public course;

    constructor(string memory _course) {
        teacher = msg.sender;
        course = _course;
    }

    function setScore(address student,uint8 _score) public onlyTeacher verifyScore(_score) {
        scores[student] = _score;
        emit ScoreSet(student,_score);
    }
    
    function getScore() public view returns(uint8 sc) {
        sc = scores[msg.sender];
    }

    modifier onlyTeacher {
        require(msg.sender == teacher,"ERR: Only Teacher can set score");
        _;
    }

    modifier verifyScore(uint8 num) {
        require(num >= 0 && num <= 100,"ERR: Score must be between 0 and 100");
        _;
    }

    event ScoreSet(address student,uint8 score);
}
