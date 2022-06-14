async function pagePartReady(){

}

async function listPredicts(){
  new Vue({
    el: '#mypredicts',
    data: {
      cards: mypredicts,
      subjects: allsubject
    }
  })
}