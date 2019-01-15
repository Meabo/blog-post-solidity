pragma solidity ^0.5.2;

interface BlogPostInterface
{
    function createComment(string calldata message) external returns(uint index);
    function deleteComment(uint id) external;
    function edit(string calldata content, uint id) external;
    function disableComments() external;
    function getCommentCount() external view returns (uint);

}
