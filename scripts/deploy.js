const main = async () => {
  const crowdfundingFactory = await hre.ethers.getContractFactory('Crowdfunding')
  const crowdfundingContract = await crowdfundingFactory.deploy()

  await crowdfundingContract.deployed()

  console.log('Crwodfunding deployed to: ', crowdfundingContract.address)

  // EXAMPLE CREATE CAMPAIGN
  const createCampaign = await crowdfundingContract.createCampaign("Image", "Title", "Descriptin", 12345, 678910)
  const txReceipt = await createCampaign.wait()
  console.log("event non-anonymous", txReceipt.events)
}

  ; (async () => {
    try {
      await main()
      process.exit(0)
    } catch (error) {
      console.error(error)
      process.exit(1)
    }
  })()