pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DemoCollection is Ownable, ERC721 {
    using Strings for uint256;
    string public baseUri;

    mapping(address => bool) public isWhitelisted;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseUri
    ) ERC721(_name, _symbol) {
        baseUri = _baseUri;
    }

    function mint(address _to, uint256 _tokenId) public {
        _safeMint(_to, _tokenId);
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory ) {
        	return string (
                abi.encodePacked(baseUri, "/", _tokenId.toString(), ".json")
            );
    }

    function addToWhitelist(address[] memory _addresses)
}