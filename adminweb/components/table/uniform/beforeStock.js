import React, { useState, useEffect } from "react";
import Link from "next/link";

import networkHandler from "configs/networkHandler";

import styles from "styles/components/table.module.scss";

const Table = ({ list }) => {
  console.log(list);
  return (
    <div>
      <div className={styles["table-border"]}>
        <div className={styles["table-header-row"]}>
          <div className={styles["table-beforeStock-header1"]}>코드</div>
          <div className={styles["table-beforeStock-header2"]} />
          <div className={styles["table-beforeStock-header3"]}>학교</div>
          <div className={styles["table-beforeStock-header4"]}>품목</div>
          <div className={styles["table-beforeStock-header5"]}>기부자</div>
          <div className={styles["table-beforeStock-header6"]}>연락처</div>
          <div className={styles["table-beforeStock-header8"]}>수거방법</div>
          <div className={styles["table-beforeStock-header7"]}>
            주소 (방문복지센터)
          </div>
          <div className={styles["table-beforeStock-header9"]}>신청날짜</div>
        </div>
        <div>
          {list.map((data, i) => (
            <Link href={`/uniform?id=${data.code}`} key={String(i)}>
              <a className={styles["table-section-row"]}>
                <div className={styles["table-beforeStock-section1"]}>
                  {data.code}
                </div>
                <div className={styles["table-beforeStock-section2"]}>
                  <div
                    style={{
                      backgroundImage: `url(${networkHandler.getImageFromServer(
                        data.images[0]
                      )})`,
                    }}
                  />
                </div>
                <div className={styles["table-beforeStock-section3"]}>
                  {data["filter-school"]}
                </div>
                <div className={styles["table-beforeStock-section4"]}>
                  {data["filter-clothType"].join(" / ")}
                </div>
                <div className={styles["table-beforeStock-section5"]}>
                  {data["giverName"]}
                </div>
                <div className={styles["table-beforeStock-section6"]}>{`${data[
                  "giverPhone"
                ].substring(0, 3)}-${data["giverPhone"].substring(3, 7)}-${data[
                  "giverPhone"
                ].substring(7, 11)}`}</div>
                <div className={styles["table-beforeStock-section8"]}>
                  {data["giverDeliveryType"]}
                </div>
                <div className={styles["table-beforeStock-section7"]}>
                  {data["giverAddress"] || "-"}
                </div>
                <div className={styles["table-beforeStock-section9"]}>
                  {data.code
                    ? `20${data.code.substring(0, 2)}.${data.code.substring(
                        2,
                        4
                      )}.${data.code.substring(4, 6)}`
                    : "미지정"}
                </div>
              </a>
            </Link>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Table;
