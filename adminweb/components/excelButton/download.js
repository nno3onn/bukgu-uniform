import React from "react";
import fileSaver from "file-saver";
import xlsx from "xlsx";
import styles from "styles/components/xlsx.module.scss";

const getdateFormat = (date) => {
  return `20${date.substring(0, 2)}-${date.substring(2, 4)}-${date.substring(
    4,
    6
  )}`;
};

const ExcelButton = ({ csvData, fileName }) => {
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
      const applicationDate = code === null ? "미지정" : getdateFormat(date);
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

export default ExcelButton;
