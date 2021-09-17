import React, { useState, useEffect } from "react";
import Link from "next/link";

import styles from "styles/components/table.module.scss";
import networkHandler from "configs/networkHandler";

const Table = ({ list }) => {
  console.log(list);
  return (
    <div>
      <div className={styles["table-border"]}>
        <div className={styles["table-header-row"]}>
          <div className={styles["table-beforeShop-header1"]}>코드</div>
          <div className={styles["table-beforeShop-header2"]} />
          <div className={styles["table-beforeShop-header3"]}>학교</div>
          <div className={styles["table-beforeShop-header4"]}>품목</div>
          <div className={styles["table-beforeShop-header5"]}>구매자</div>
          <div className={styles["table-beforeShop-header6"]}>연락처</div>
          <div className={styles["table-beforeShop-header7"]}>주소</div>
          <div className={styles["table-beforeShop-header8"]}>수령방법</div>
          <div className={styles["table-beforeShop-header9"]}>신청날짜</div>
        </div>
        <div>
          {list.map((data, i) => (
            <Link href={`/uniform?id=${data.code}`} key={String(i)}>
              <a className={styles["table-section-row"]}>
                <div className={styles["table-beforeShop-section1"]}>
                  {data.code}
                </div>
                <div className={styles["table-beforeShop-section2"]}>
                  <div
                    style={{
                      backgroundImage: `url(${networkHandler.getImageFromServer(
                        data.images[0]
                      )})`,
                    }}
                  />
                </div>
                <div className={styles["table-beforeShop-section3"]}>
                  {data["filter-school"]}
                </div>
                <div className={styles["table-beforeShop-section4"]}>
                  {data["filter-clothType"].join(" / ")}
                </div>
                <div className={styles["table-beforeShop-section5"]}>
                  {data["receiverName"]}
                </div>
                <div className={styles["table-beforeShop-section6"]}>{`${data[
                  "receiverPhone"
                ].substring(0, 3)}-${data["receiverPhone"].substring(
                  3,
                  7
                )}-${data["receiverPhone"].substring(7, 11)}`}</div>
                <div className={styles["table-beforeShop-section7"]}>
                  {data["receiverAddress"] || "-"}
                </div>
                <div className={styles["table-beforeShop-section8"]}>
                  {data["receiverDeliveryType"] === "배송 요청"
                    ? "배송 요청"
                    : "직접 방문"}
                </div>
                <div className={styles["table-beforeShop-section9"]}>
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
