import React from "react";
import styles from "styles/components/xlsx.module.scss";
import exportExcel from "utils/exportExcel";

const ExcelButton = ({ csvData, fileName }) => (
  <button
    type="button"
    className={styles["xlsx-button"]}
    onClick={() => exportExcel(csvData, fileName)}
  >
    엑셀로 내려받기
  </button>
);

export default ExcelButton;
