// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract ReceberFundos {
    string public nome;
    address public owner;
    mapping(address => uint) public balanceOf;

    error ValorInsuficiente();

    receive() external payable {}

    modifier onlyOwner {
        require (msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function mudaNome(string memory _novoNome) public payable{
        if (msg.value < 1 ether) {
            revert ValorInsuficiente();
        }
        nome = _novoNome;
    }

    function saldoContrato() external view returns(uint) {
        return address(this).balance;
    }

    function transferir(address _receiver, uint _valor) public onlyOwner {
        require(address(this).balance >= _valor);
        require(_receiver != address(0));
        address payable receiver = payable(_receiver);
        
        receiver.transfer(_valor);
    }

    function mostraSaldo(address _account) external view returns (uint) {
        return _account.balance;
    }
}
