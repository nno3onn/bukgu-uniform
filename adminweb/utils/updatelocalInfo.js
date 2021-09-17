const updateLocalInfo = (key, value) => {
  const infoData = JSON.parse(localStorage.getItem("info"));

  infoData[key] = Number(infoData[key]) + Number(value);

  localStorage.setItem("info", JSON.stringify(infoData));

  return infoData[key] < 0 ? infoData[key] : 0;
};

export default updateLocalInfo;
