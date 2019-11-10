pragma solidity ^0.5.8;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption{
    //Retreive the address of the adoption contract to be tested
    Adoption adoption = Adoption(DeployedAddresses.Adoption());
    
    //Set ID of the pet to be used for testing
    uint expectedId = 8;
    
    //Set address of the owner of this contract to be the expected owner
    address expectedAdopter = address(this);
    
    //Test the adopt() function
    function testUserCanAdoptPet() public{
        uint returnedId = adoption.adopt(expectedId);
        
        Assert.equal(expectedId, returnedId, "Adoption of the expected pet should match what is returned.");
    }
    
    // Testing retrieval of a single pet's owner
    function testGetAdopterAddressByPetId() public {
      address adopter = adoption.adopters(expectedId);
    
      Assert.equal(adopter, expectedAdopter, "Owner of the expected pet should be this contract");
    }
        
    //Testing retrieval of all pet owners
    function testGetAdopterAddressByPetIdInArray() public {
        //Store adopters in memory rather than contract's storage
        address[16] memory adopters = adoption.getAdopters();
    
        Assert.equal(adopters[expectedId], expectedAdopter, "Owner of the expected pet should be this contract");
    }
}
