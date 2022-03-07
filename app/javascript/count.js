function count (){
  const memoContent  = document.getElementById("memo_content");
  memoContent.addEventListener("keyup", () => {
    const countVal = memoContent.value.length;
    const charNum  = document.getElementById("char_num");
    charNum.innerHTML = `${countVal}文字`;
  });
};

window.addEventListener('load', count);