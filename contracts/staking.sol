// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 创建一个管理质押和奖励的合约
contract StakingRewards {

    mapping(address => uint256) public stakedAmount; // 存储用户质押的代币数量
    mapping(address => uint256) public rewards; // 存储用户的奖励数量

    uint256 public rewardRate = 10; // 每单位质押的奖励

    // 用户质押代币
    function stake(uint256 amount) public {
        stakedAmount[msg.sender] += amount; // 将质押的代币数量增加
    }

    // 计算用户的质押奖励
    function calculateRewards(address user) public view returns (uint256) {
        return stakedAmount[user] * rewardRate; // 奖励等于质押数量乘以奖励率
    }

    // 用户领取奖励
    function claimRewards() public {
        uint256 reward = calculateRewards(msg.sender); // 计算用户应得的奖励
        rewards[msg.sender] += reward; // 增加用户奖励
        stakedAmount[msg.sender] = 0; // 领取奖励后重置质押数量
    }

    // 取出质押的金额
    function withdraw(uint256 amount) public {
        require(amount <= stakedAmount[msg.sender], "Insufficient balance");
        stakedAmount[msg.sender] -= amount;
    }

}

