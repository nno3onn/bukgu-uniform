const num = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

const onlyNum = (value) => {
  const isNum = num.includes(value[value.length - 1]);
  return isNum ? value : value.substr(0, value.length - 1);
};

export default onlyNum;
