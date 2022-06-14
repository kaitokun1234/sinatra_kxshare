$('.btn.reload').click(async function () {
  conole.log("aa");
  await getAllSubject();
  console.log(allsubject);
})