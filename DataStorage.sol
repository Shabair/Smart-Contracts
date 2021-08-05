// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DataStorage{
    
    address payable owner;
    
    struct Data{
        uint id;
        string fname;
        string lname;
        string email;
        address person;
    }
    
    Data[] private UserData;
    
    uint private usersCount = 0;
    
    constructor(address payable _owner){
        //owner = payable(msg.sender);
        owner = _owner;
    }
    
    function setData(string memory _fname, string memory _lname, string memory _email) public payable{
        require(msg.value == 1000,'Insufficient Balance');
        UserData.push(Data(++usersCount,_fname,_lname,_email,msg.sender));
    }
    
    function getUsersCount()public view returns(uint){
        return usersCount;
    }
    
    function getData(uint id)public view returns(uint _i,string memory _fname, string memory _lname, string memory _email, address _a){
        for(uint i = 0; i < usersCount; i++){
            if(UserData[i].id == id){
                return (UserData[i].id,UserData[i].fname,UserData[i].lname,UserData[i].email,UserData[i].person);
            }
        }
    }
    
    modifier onlyOwner(){
        require(owner == msg.sender,'Only Owner Allowed');
        _;
    }
    
    function getContractBalance() public view onlyOwner returns(uint){
        return address(this).balance;
    }
    
    function withdrawFunds() public onlyOwner{
        owner.transfer(address(this).balance);
    }
    
    
}

