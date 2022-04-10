const main = async () => {
    const crowdfundingFactory = await hre.ethers.getContractFactory('Crowdfunding')
    const crowdfundingContract = await crowdfundingFactory.deploy()

    await crowdfundingContract.deployed()

    console.log('Crwodfunding deployed to: ', crowdfundingContract.address)
}

;(async () => {
    try {
        await main()
        process.exit(0)
    } catch (error) {
        console.error(error)
        process.exit(1)
    }
})()