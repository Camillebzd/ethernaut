import { ethers } from "hardhat";

const SEPOLIA_RPC_URL =
    process.env.SEPOLIA_RPC_URL ||
    "https://eth-sepolia.g.alchemy.com/v2/your-api-key";

async function main() {
    const addressContract = "0x212630Ec473C6842E3496bC968d78f8163910e88"; // this is my instance contract
    const provider = ethers.getDefaultProvider(SEPOLIA_RPC_URL);
    const passwordFound = await provider.getStorage(addressContract, 5);
    console.log("password found: ", passwordFound);
    // result: "0x06df472473cb483cfe8ba303daef2204a4513b7fd6ce8f8f12833409946cfec7" // 32 bytes
    // convert in 16 bytes: "0x06df472473cb483cfe8ba303daef2204"
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
