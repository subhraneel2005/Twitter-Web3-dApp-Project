// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


// 1️⃣ Create a Twitter Contract
// 2️⃣ Create a mapping between user and tweet 
// 3️⃣ Add function to create a tweet and save it in mapping
// 4️⃣ Create a function to get Tweet 
// 5️⃣ Add array of tweets 
// 1️⃣ Define a Tweet Struct with author, content, timestamp, likes
// 2️⃣ Add the struct to array
// 3️⃣ Test Tweets
// 1️⃣ Add a function called changeTweetLength to change max tweet length
// HINT: use newTweetLength as input for function
// 2️⃣ Create a constructor function to set an owner of contract
// 3️⃣ Create a modifier called onlyOwner
// 4️⃣ Use onlyOwner on the changeTweetLength function

contract Twitter{

    uint16 public  MAX_TWEET_LENGTH = 280;
    address public owner;

    struct Tweet{
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    constructor(){
        owner = msg.sender;
    }

    mapping(address =>  Tweet[]) public tweets;

    modifier isOwner(){
        require(msg.sender == owner, "YOU ARE NOT THE OWNER!!!!!!");
        _;
    }

    function changeTweetLength(uint16 _newTweetLength) public isOwner{
        MAX_TWEET_LENGTH = _newTweetLength;
    }

    function addTweet(string memory _tweet) public{

        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Your tweet is too long brah!");
        
        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
    }

    function likeTweet(address _author, uint256 _id) external{
        require(tweets[_author][_id].id == _id, "TWEET DOES NOT EXIST");
        tweets[_author][_id].likes++;
    }

    function unlikeTweet(address _author, uint256 _id) external{
        require(tweets[_author][_id].id == _id, "TWEET DOES NOT EXIST");
        require(tweets[_author][_id].likes>0, "LIKES ARE ALREADY 0 brah!");
        tweets[_author][_id].likes--;
    }

    function getAllTweets(address _owner) public view returns(Tweet[] memory){
        return tweets[_owner];
    }

    function getSingleTweetById(uint _id) public view returns(Tweet memory){
        return tweets[msg.sender][_id];
    }
}