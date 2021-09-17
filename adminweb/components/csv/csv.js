import React from "react";
import fileSaver from "file-saver";
import xlsx from "xlsx";
import styles from "styles/components/xlsx.module.scss";

const dateFormat = (date) => {
  date = new Date(date);
  console.log("date", date);
  let month = date.getMonth() + 1;
  let day = date.getDate();

  month = month >= 10 ? month : "0" + month;
  day = day >= 10 ? day : "0" + day;

  return date.getFullYear() + "-" + month + "-" + day;
};

const CSVSaver = (props) => {
  const { csvData, fileName } = props;
  // const title = {'연번','신청일자','코드',}
  console.log("csvData", csvData, fileName);
  const fileType = "";
  const fileExtension = ".xlsx";

  const exportToCSV = (csvDatas, fileName) => {
    let csvJSON = new Array();

    let i = 0;
    csvDatas.map((csvData) => {
      const { code, giverName, giverPhone, giverDeliveryType, giverAddress } =
        csvData;
      const school = csvData["filter-school"];
      const gender = csvData["filter-gender"];
      const clothType = csvData["filter-clothType"].join(" / ");
      let size = new Array();
      csvData.uniforms.map((uniform) => {
        size.push(uniform.size);
      });
      size = size.join(" / ");
      const date = code.split("-")[0];
      const applicationDate =
        code === null
          ? "미지정"
          : `20${date.substring(0, 2)}-${date.substring(2, 4)}-${date.substring(
              4,
              6
            )}`;
      const complete = csvData.dateStock === null ? "X" : "O";

      csvJSON.push({
        연번: ++i,
        신청일자: applicationDate,
        코드: code,
        학교: school,
        성별: gender,
        품목: clothType,
        사이즈: size,
        기부자: giverName,
        연락처: giverPhone,
        수거방법: giverDeliveryType,
        주소: giverAddress,
        수거완료: complete,
      });
    });

    const ws = xlsx.utils.json_to_sheet(csvJSON);
    const wb = { Sheets: { data: ws }, SheetNames: ["data"] };
    const excelBuffer = xlsx.write(wb, { bookType: "xlsx", type: "array" });
    const data = new Blob([excelBuffer], { type: fileType });
    fileSaver.saveAs(data, fileName + fileExtension);
  };

  return (
    <button
      className={styles["xlsx-button"]}
      onClick={() => exportToCSV(csvData, fileName)}
    >
      엑셀로 내려받기
    </button>
  );
};

export default CSVSaver;
