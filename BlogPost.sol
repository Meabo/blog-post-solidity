
pragma solidity ^0.5.2;

import './BlogPostInterface.sol';
import './Ownable.sol';

contract BlogPost is BlogPostInterface, Ownable
{
    
    struct Comment
    {
        address author;
        string message;
    }

    string public blogpost_title;
    string public blogpost_content;
    Comment[] public comments_array;
    bool allowed_comments;

    constructor(string memory title, string memory content) public
    {
        blogpost_title = title;
        blogpost_content = content;
        allowed_comments = true;
    }

    function createComment(string memory text) public commentsAllowed returns(uint index)
    {
        index = comments_array.push(Comment(msg.sender, text)) - 1;
    }

    function deleteComment(uint index) public
    {
      require(msg.sender == comments_array[index].author, "Only authors can delete their comments");
      delete comments_array[index];
    }

    function edit(string memory content, uint id) public
    {
      require(msg.sender == comments_array[id].author, "Only authors can modify their comments");
      comments_array[id].message = content;
    }

    modifier commentsAllowed() {
        require(allowed_comments == true);
        _;
    }

    function disableComments()  public onlyOwner()
    {
        allowed_comments = false;
    }

    function getCommentCount() public view returns (uint count)
    {
        return comments_array.length;
    }




}
