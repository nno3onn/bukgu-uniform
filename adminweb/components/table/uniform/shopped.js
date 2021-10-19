/* eslint-disable comma-dangle */
/* eslint-disable react/prop-types */
import React from "react";
import Link from "next/link";
import networkHandler from "configs/networkHandler";
import Skeleton from "react-loading-skeleton";

import styles from "styles/components/table.module.scss";

const Table = ({ list }) => (
  <div>
    <div className={styles["table-border"]}>
      <div className={styles["table-header-row"]}>
        <div className={styles["table-shopped-header1"]}>코드</div>
        <div className={styles["table-shopped-header2"]} />
        <div className={styles["table-shopped-header3"]}>학교</div>
        <div className={styles["table-shopped-header4"]}>품목</div>
        <div className={styles["table-shopped-header5"]}>기부자</div>
        <div className={styles["table-shopped-header6"]}>구매자</div>
        <div className={styles["table-shopped-header7"]}>입고일</div>
        <div className={styles["table-shopped-header8"]}>배송일</div>
      </div>
      <div>
        {!Array.isArray(list) ? (
          <div className={styles["table-section-column"]}>
            {[...Array(7)].map(() => (
              <div className={styles["table-section-row"]}>
                <div className={styles["table-shopped-section1"]}>
                  <Skeleton height={16} width={120} />
                </div>
                <div className={styles["table-shopped-section2"]}>
                  <Skeleton height={82} width={82} />
                </div>
                <div className={styles["table-shopped-section3"]}>
                  <Skeleton height={16} width={80} />
                </div>
                <div className={styles["table-shopped-section4"]}>
                  <Skeleton height={16} width={250} />
                </div>
                <div className={styles["table-shopped-section5"]}>
                  <Skeleton height={16} width={50} />
                </div>
                <div className={styles["table-shopped-section6"]}>
                  <Skeleton height={16} width={50} />
                </div>
                <div className={styles["table-shopped-section7"]}>
                  <Skeleton height={16} width={80} />
                </div>
                <div className={styles["table-shopped-section8"]}>
                  <Skeleton height={16} width={80} />
                </div>
              </div>
            ))}
          </div>
        ) : (
          list.map((data, i) => {
            const di = new Date(data.dateStock);
            const dis = `${di.getFullYear()}. ${
              di.getMonth() + 1 >= 10
                ? di.getMonth() + 1
                : `0${di.getMonth() + 1}`
            }. ${di.getDate() >= 10 ? di.getDate() : `0${di.getDate()}`}`;
            const dou = new Date(data.dateDelivery);
            const dous = `${dou.getFullYear()}. ${
              dou.getMonth() + 1 >= 10
                ? dou.getMonth() + 1
                : `0${dou.getMonth() + 1}`
            }. ${dou.getDate() >= 10 ? dou.getDate() : `0${dou.getDate()}`}`;
            return (
              <Link href={`/uniform?id=${data.code}`} key={String(i)}>
                <a className={styles["table-section-row"]}>
                  <div className={styles["table-shopped-section1"]}>
                    {data.code}
                  </div>
                  <div className={styles["table-shopped-section2"]}>
                    <div
                      style={{
                        backgroundImage: `url(${networkHandler.getImageFromServer(
                          data.images[0]
                        )})`,
                      }}
                    />
                  </div>
                  <div className={styles["table-shopped-section3"]}>
                    {data["filter-school"]}
                  </div>
                  <div className={styles["table-shopped-section4"]}>
                    {data["filter-clothType"].join(" / ")}
                  </div>
                  <div className={styles["table-shopped-section5"]}>
                    {data.giverName}
                  </div>
                  <div className={styles["table-shopped-section6"]}>
                    {data.receiverName}
                  </div>
                  <div className={styles["table-shopped-section7"]}>{dis}</div>
                  <div className={styles["table-shopped-section8"]}>{dous}</div>
                </a>
              </Link>
            );
          })
        )}
      </div>
    </div>
  </div>
);

export default Table;
