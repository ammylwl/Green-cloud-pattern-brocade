// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 创建一个管理产品所有权的合约
contract OwnershipRegistry {

    // 定义产品数据结构，包含产品ID、所有者地址和价格
    struct Product {
        string productID; // 产品ID
        address owner; // 当前所有者地址
        uint256 price; // 产品价格
    }

    mapping(uint256 => Product) public products; // 通过产品ID映射到Product结构体
    uint256 public productCounter; // 记录产品ID的计数器

    // 注册新产品，并记录价格和初始所有者
    function registerProduct(string memory productID, uint256 price) public {
        productCounter++; // 增加计数器
        products[productCounter] = Product({ // 创建新的Product结构体并存储
            productID: productID,
            owner: msg.sender, // 设置调用者为产品的初始所有者
            price: price // 设置产品价格
        });
    }

    // 转移产品所有权
    function transferOwnership(uint256 productID, address newOwner) public {
        require(products[productID].owner == msg.sender, "Only the owner can transfer ownership"); // 确保调用者为当前所有者
        products[productID].owner = newOwner; // 更新产品所有者为新地址
    }
}

