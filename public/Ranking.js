async function pagePartReady(){
  console.log(networkId);
  await rank();
  console.log("seted ranking");
}

async function rank(){
  let datas = {};
  let predictCount = await contract.methods.predictCount().call();
  for(i=0;i<predictCount;i++){
    const predict = await contract.methods.predicts(i).call();
    let data = datas[predict.predictor];
    if(datas[predict.predictor] == undefined){
      datas[predict.predictor] = {};
      data = datas[predict.predictor];
      data.total = 0;
      data.times = 0;
      data.predictor = predict.predictor;
    }
    const subjectresult = await contract.methods.subjectResult(predict.subjectID).call();
    if(subjectresult == 0){
      continue;
    }
    data.total += (parseFloat(predict.value) / parseFloat(subjectresult));
    data.times += 1;
    data.accuracy = data.total / data.times * 100;
    datas[predict.predictor] = data;
  }
  console.log(datas);

  let datasarray = [];
  Object.keys(datas).forEach(function (key) {
    datasarray.push(datas[key]);
  })
  console.log(datasarray);

  let ranking = datasarray.sort(function(a,b) {
    return (a.accuracy > b.accuracy) ? -1 : 1;
  })

  let _i = 0;
  ranking.forEach(function (_dic){
    _i++
    _dic.rank = _i;
  })

  let divranking = new Vue({
    el: '#rank',
    data: {
      cards: ranking,
    }
  })
}
