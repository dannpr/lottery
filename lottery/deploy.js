const HDWalletProvider = require("truffle-hdwallet-provider");
const Web3 = require("web3");
const { interface, bytecode } = require("./compile");

const provider = new HDWalletProvider(
  "output invite rude police twice sound fragile improve mercy pride trouble discover",
  "https://rinkeby.infura.io/v3/ea78e289cfa4426ab573b5bb3c1efea3"

);
const web3 = new Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();

  console.log("Attempting to deploy from account", accounts[0]);

  const result = await new web3.eth.Contract(JSON.parse(interface))
    .deploy({ data: bytecode })
    .send({ gas: '1000000', gasPrice: '5000000000', from: accounts[0] });

  //we need the console.log interface and contract address
  //to add those to our react code
  console.log(interface);
  console.log("Contract deployed to", result.options.address);
};
deploy();
