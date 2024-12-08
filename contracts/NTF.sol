// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 引入ERC721标准和URI存储功能
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// YunJinNFT合约继承ERC721URIStorage和Ownable，支持NFT创建和所有权控制
contract YunJinNFT is ERC721URIStorage, Ownable {
    uint256 public tokenCounter; // 用于生成新的NFT ID

    // 定义结构体，存储产品溯源信息
    struct ProductInfo {
        string productID; // 产品编号（UUID）
        string rawMaterial; // 原材料信息
        string productionProcess; // 生产过程
        string artisanInfo; // 工匠信息
        string esgData; // ESG数据
        string origin; // 产地信息
        string craftsmanshipCertification; // 工艺认证
    }

    mapping(uint256 => ProductInfo) public products; // 存储每个NFT对应的产品信息

    // 构造函数，初始化NFT的名称和符号，并指定初始拥有者
    constructor(address initialOwner) ERC721("YunJin", "YJN") Ownable() {
        transferOwnership(initialOwner); // 设置合约的初始所有者
        tokenCounter = 0; // 初始化计数器
    }

    // mintNFT函数用于铸造新的NFT，并记录产品溯源数据
    function mintNFT(
        address recipient, // NFT接收者地址
        string memory productID, // 产品编号（UUID）
        string memory rawMaterial, // 原材料信息
        string memory productionProcess, // 生产过程信息
        string memory artisanInfo, // 工匠信息
        string memory esgData, // ESG数据
        string memory origin, // 产地信息
        string memory craftsmanshipCertification // 工艺认证信息
    ) public onlyOwner returns (uint256) {
        uint256 newTokenId = tokenCounter; // 使用当前计数器生成新的Token ID
        _safeMint(recipient, newTokenId); // 铸造NFT并分配给接收者

        // 将溯源信息存储在mapping中
        products[newTokenId] = ProductInfo({
            productID: productID,
            rawMaterial: rawMaterial,
            productionProcess: productionProcess,
            artisanInfo: artisanInfo,
            esgData: esgData,
            origin: origin,
            craftsmanshipCertification: craftsmanshipCertification
        });

        // 创建JSON格式的元数据，包含溯源信息
        string memory tokenURI = string(abi.encodePacked(
            "{",
            '"productID": "', productID, '",',
            '"rawMaterial": "', rawMaterial, '",',
            '"productionProcess": "', productionProcess, '",',
            '"artisanInfo": "', artisanInfo, '",',
            '"esgData": "', esgData, '",',
            '"origin": "', origin, '",',
            '"craftsmanshipCertification": "', craftsmanshipCertification, '"',
            "}"
        ));

        _setTokenURI(newTokenId, tokenURI); // 为NFT设置元数据URI
        tokenCounter++; // 增加计数器以生成新的ID
        return newTokenId; // 返回新NFT的ID
    }

    // 获取特定NFT的溯源信息
    function getProductInfo(uint256 tokenId) public view returns (ProductInfo memory) {
        return products[tokenId]; // 返回存储的产品信息
    }
}
