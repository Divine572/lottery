from brownie import Lottery, accounts, config, network

def deploy_lottery():
    # Load the account to deploy from
    dev = accounts.add(config["wallets"]["from_key"])
    print(f"Deploying from {dev.address}")

    # Deploy the contract
    lottery = Lottery.deploy(5, 50, {"from": dev})

    print(f"Lottery contract deployed to {lottery.address}")

def main():
    # Set the network to deploy to
    network_name = network.show_active()
    print(f"Deploying to {network_name} network")

    # Call the deploy function
    deploy_lottery()