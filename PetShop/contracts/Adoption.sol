pragma solidity ^0.5.8;

contract Adoption{
    //Array of addresses to store the addresses of the adopters
    address[16] public adopters;
    mapping(address => bool) adopterStatus;

    //NOTE: As of this version of the DApp, only one person can apply to adopt a pet.
    //A future version of the contract will integrate a Bidding system so that multiple people
    //can opt for the same pet and then bid for it.

    //Modifier to ensure that one person can only opt to adopt one pet
    modifier newAdopter(){
        require(!adopterStatus[msg.sender], "Sorry, you have already opted to adopt a pet");
        _;
    } 


    //Function to adopt a pet, indicated by its petId
    function adopt(uint petId) public newAdopter returns(uint){
        //Validate the input petId and ensure that pet hasn't been adopted yet
        require(petId >= 0 && petId <= 15);
	require(adopters[petId] == address(0), "Sorry, this pet isn't available for adoption anymore");

        //Assign the adopter's address to this petId and update the adopter's adoption status
	adopters[petId] = msg.sender;
        adopterStatus[msg.sender] = true;

        //Return the petId to indicate the adoption process has been successfully completed.
	//Also, this simplifies the testing process.
	return petId;
    }

    //Function to return the list of adopters
    function getAdopters() public view returns(address[16] memory){
        return adopters;
    }
}
