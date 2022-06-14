async function pagePartReady(){
  await setSelectSubjects();
}

async function setSelectSubjects(){
  new Vue({
    el: '#post',
    data: {
      cards: allsubject
    }
  })
}

$('.btn.predict.make').click(async () => {
  console.log("選択したsubjectid→",$('select.subject').val());
  try {
    const makePredictTx = await contract.methods.makePredict($('select.subject').val(), $('input.predict.value').val(), web3.utils.toWei($('input.predict.amount').val(), "ether")).send({ from: user });
  } catch (err) {
    alert(err);
  }
})