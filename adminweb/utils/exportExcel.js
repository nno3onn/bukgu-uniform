import fileSaver from "file-saver";
import xlsx from "xlsx";

const getDateFormat = (date) => {
  const year = `20${date.substring(0, 2)}`;
  const month = date.substring(2, 4);
  const day = date.substring(4, 6);
  return `${year}-${month}-${day}`;
};

const exportExcel = (csvArray, fileName) => {
  const csvJSON = csvArray.map((csvData, index) => {
    const {
      code,
      giverName,
      giverPhone,
      giverDeliveryType,
      giverAddress,
      uniforms,
      dateStock,
    } = csvData;
    const school = csvData["filter-school"];
    const gender = csvData["filter-gender"];
    const clothType = csvData["filter-clothType"].join(" / ");
    const uniformSize = uniforms.map((uniform) => uniform.size).join(" / ");
    const date = code.split("-")[0];

    const dateUndefined = "미지정";
    const dateDefined = getDateFormat(date);
    const applicationDate = code === undefined ? dateUndefined : dateDefined;
    const complete = dateStock === undefined ? "X" : "O";

    return {
      연번: index + 1,
      신청일자: applicationDate,
      코드: code,
      학교: school,
      성별: gender,
      품목: clothType,
      사이즈: uniformSize,
      기부자: giverName,
      연락처: giverPhone,
      수거방법: giverDeliveryType,
      주소: giverAddress,
      수거완료: complete,
    };
  });
  const fileType = "";
  const fileExtension = "xlsx";
  const ws = xlsx.utils.json_to_sheet(csvJSON);
  const wb = { Sheets: { data: ws }, SheetNames: ["data"] };
  const excelBuffer = xlsx.write(wb, {
    bookType: fileExtension,
    type: "array",
  });
  const data = new Blob([excelBuffer], { type: fileType });
  fileSaver.saveAs(data, `${fileName}.${fileExtension}`);
};

export default exportExcel;
