let web3, contract, user;
let allsubject = [];
let getUnclaimed = async () => await contract.methods.unclaimed(user).call();
let predicts= [];
let mypredicts= [];
let otherspredicts= [];
let predictCount;
const networkId = "31337"

$(document).ready(async () => {
  web3 = await new Web3(Web3.givenProvider);
  await switchNetwork(networkId);
  contract = await new web3.eth.Contract(abi.pmarket, abi.marketAddr);
  await login();
  await pagePartReady();
})


$(document).on("click", ".btn.login", async function () {
  await login();
})

async function login(){
  await switchNetwork(networkId);
  try {
    const accounts = await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    if(await switchNetwork(networkId)){
      web3 = await new Web3(Web3.givenProvider);
      contract = await new web3.eth.Contract(abi.pmarket, abi.marketAddr);
      await getAllSubject();
      //await setSelectSubject();
      predictCount = await contract.methods.predictCount().call();
      for (i = 0; i < predictCount; i++) {
        let _predict = await contract.methods.predicts(i).call();
        _predict.predictId = i;
        _predict.amountEth = web3.utils.fromWei(_predict.amount, "ether");
        predicts.push(_predict);
      }
      user = accounts[0];
      $(".btn.login").html(user.slice(0, 3) + "…" + user.slice(-3));
      let myunclaimed = await getUnclaimed();
      $('p.unclaimed').html("請求可能残高" + web3.utils.fromWei(myunclaimed, "ether"));
      $('div.loginRequirement').show();
      const owner = await contract.methods.owner().call();
      if(owner.toUpperCase() == user.toUpperCase()){
        $('#managementBtn').show();
      }
    }
  } catch (error) {
    alert(error.message);
  }
  await createArrays();
  //await listPredicts();
}

async function createArrays(){
  predicts.forEach(async function(_predict){
    if(_predict.predictor.toUpperCase() == user.toUpperCase()){
      const subjectResult = await contract.methods.subjectResult(_predict.subjectID).call();
      if(subjectResult != 0 && _predict.end == false){
        _predict.showable = false;
      }else {
        _predict.showable = true;
      }
      mypredicts.push(_predict);
    }
    if(_predict.predictor.toUpperCase() != user.toUpperCase()){
      const _predictId = predicts.indexOf(_predict);
      const youhave = await contract.methods.purchasedPredicts(user, _predictId).call();
      _predict.value = youhave ? _predict.value : "購入したら見れる";
      _predict.buyable = youhave ? true : false;
      otherspredicts.push(_predict);
    }
  });
}

$('.btn.claim').click(async () => {
  try {
    const claimTx = await contract.methods.claim().send({ from: user });
  } catch (err) {
    alert(err);
  }
})

$('.btn.subject.make').click(async () => {
  try {
    const makeSubjectTx = await contract.methods.makeSubject($('input.subject.title').val()).send({ from: user });
  } catch (err) {
    alert(err);
  }
})

async function getAllSubject() {
  const subjectCount = await contract.methods.subjectCount().call();
  for (i = 0; i < subjectCount; i++) {
    const _title = await contract.methods.subjects(i).call();
    allsubject.push(_title);
  }
}

async function buy(_id) {
  const predict = await contract.methods.predicts(0).call();
  try {
    await contract.methods
      .buyPredict(_id)
      .send({ from: user, value: predict.amount });
  } catch (err) {
    throw (err);
  }
}

async function deposit(amount) {
  try {
    await contract.methods
      .deposit()
      .send({ from: user, value: amount });
  } catch (err) {
    throw (err);
  }
}

async function showResult(_id) {
  try{
    await contract.methods.showResult(_id).send({from: user});
  }catch(err){
    alert(err);
  }
}

const switchNetwork = async (chainId) => {

  const currentChainId = await web3.eth.net.getId();
  
  if (currentChainId !== chainId) {
    try {
      await web3.currentProvider.request({
        method: 'wallet_switchEthereumChain',
          params: [{ chainId: Web3.utils.toHex(chainId) }],
        });
      return true;
    } catch (switchError) {
      // This error code indicates that the chain has not been added to MetaMask.
      return false;
      if (switchError.code === 4902) {
        alert('add this chain id')
      }
    }
  }else{
    return true;
  }
}