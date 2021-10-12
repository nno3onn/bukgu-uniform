import React, { useState, useEffect } from "react";
import Link from "next/link";

import networkHandler from "configs/networkHandler";
import Skeleton from "react-loading-skeleton";
import styles from "styles/components/table.module.scss";

const Table = ({ list }) => {
  console.log(list);
  return (
    <div>
      <div className={styles["table-border"]}>
        <div className={styles["table-header-row"]}>
          <div className={styles["table-stock-header1"]}>코드</div>
          <div className={styles["table-stock-header2"]} />
          <div className={styles["table-stock-header3"]}>학교</div>
          <div className={styles["table-stock-header4"]}>품목</div>
          <div className={styles["table-stock-header5"]}>기부자</div>
          <div className={styles["table-stock-header6"]}>입고일</div>
        </div>
        <div>
          {" "}
          {Array.isArray(list) && list.length === 0 ? (
            <div className={styles["table-section-column"]}>
              {[...Array(20)].map(() => (
                <div className={styles["loading-wrapper"]}>
                  <Skeleton height={50} width={1100} />
                </div>
              ))}
            </div>
          ) : (
            list.map((data, i) => {
              const d = new Date(data["dateStock"]);
              const ds = `${d.getFullYear()}. ${
                d.getMonth() + 1 >= 10
                  ? d.getMonth() + 1
                  : `0${d.getMonth() + 1}`
              }. ${d.getDate() >= 10 ? d.getDate() : `0${d.getDate()}`}`;
              return (
                <Link href={`/uniform?id=${data.code}`} key={String(i)}>
                  <a className={styles["table-section-row"]}>
                    <div className={styles["table-stock-section1"]}>
                      {data.code}
                    </div>
                    <div className={styles["table-stock-section2"]}>
                      <div
                        style={{
                          backgroundImage: `url(${networkHandler.getImageFromServer(
                            data.images[0]
                          )})`,
                        }}
                      />
                    </div>
                    <div className={styles["table-stock-section3"]}>
                      {data["filter-school"]}
                    </div>
                    <div className={styles["table-stock-section4"]}>
                      {data["filter-clothType"].join(" / ")}
                    </div>
                    <div className={styles["table-stock-section5"]}>
                      {data["giverName"]}
                    </div>
                    <div className={styles["table-stock-section6"]}>{ds}</div>
                  </a>
                </Link>
              );
            })
          )}
        </div>
      </div>
    </div>
  );
};

export default Table;
