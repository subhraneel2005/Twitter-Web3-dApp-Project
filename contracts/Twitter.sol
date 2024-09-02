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

contract Twitter{

    struct Tweet{
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address =>  Tweet[]) public tweets;

    function addTweet(string memory _tweet) public{
        
        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
    }

    function getAllTweets(address _owner) public view returns(Tweet[] memory){
        return tweets[_owner];
    }

    function getSingleTweetById(address _owner, uint _id) public view returns(Tweet memory){
        return tweets[_owner][_id];
    }
}