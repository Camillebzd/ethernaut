import { ethers } from "hardhat";

const SEPOLIA_RPC_URL =
    process.env.SEPOLIA_RPC_URL ||
    "https://eth-sepolia.g.alchemy.com/v2/your-api-key";

async function main() {
    const addressContract = "0x02e9fF43F4b63d9f3f11a7CB5a34514c417Cfd7a"; // this is my instance contract
    const provider = ethers.getDefaultProvider(SEPOLIA_RPC_URL);
    const passwordFound = await provider.getStorage(addressContract, 1);
    console.log("password found: ", passwordFound);
    // result: "0x412076657279207374726f6e67207365637265742070617373776f7264203a29"
    // translate -> "A very strong secret password :)"
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
