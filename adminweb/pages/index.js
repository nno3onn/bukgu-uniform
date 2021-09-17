import React, { useEffect, useState } from "react";
import Head from "next/head";
import Link from "next/link";
import Router, { useRouter } from "next/router";

import { throttle } from "throttle-debounce";

import Nav from "components/nav";
import CSVSaver from "components/csv/csv";
import LoadingPage from "components/loading/page";

import BeforeStockTable from "components/table/uniform/beforeStock";
import StockTable from "components/table/uniform/stock";
import BeforeShopTable from "components/table/uniform/beforeShop";
import BeforeDeliveryTable from "components/table/uniform/beforeDelivery";
import ShoppedTable from "components/table/uniform/shopped";

import styles from "styles/pages/home.module.scss";
import networkHandler from "configs/networkHandler";
import apiRoutes from "configs/apiRoutes";

const Home = () => {
  const router = useRouter();
  const { table } = router.query;

  const [loading, setLoading] = useState(true);
  const [filter, setFilter] = useState("기부승인요청");
  const [search, setSearch] = useState("");

  const [localInfo, setLocalInfo] = useState({});
  const [list, setList] = useState([]);
  const [lastDoc, setLastDoc] = useState(null);

  const handleFilter = (value) => async () => {
    setFilter(value);

    let queries = `?status=${table || "기부승인요청"}`;
    if (search !== "") queries += `&keyword=${search}`;
    if (table === "기부승인요청" && value !== "전체")
      queries += `&giverDeliveryType=${value}`;
    else if (
      (table === "구매승인요청" || table === "출고대기중") &&
      value !== "전체"
    )
      queries += `&receiverDeliveryType=${value}`;
    let list = await networkHandler.getApi(
      `${apiRoutes.UNIFORM_LIST}${queries}`
    );

    if (list.data) {
      const l = list.data;
      if (l.length > 0) setLastDoc(l[l.length - 1]);
      setList(l);
    }
  };

  const handleSearch = async () => {
    let queries = `?status=${table || "기부승인요청"}`;
    if (search !== "") queries += `&keyword=${search}`;
    if (table === "기부승인요청") queries += `&giverDeliveryType=${filter}`;
    else if (table === "구매승인요청" || table === "출고대기중")
      queries += `&receiverDeliveryType=${filter}`;
    let list = await networkHandler.getApi(
      `${apiRoutes.UNIFORM_LIST}${queries}`
    );

    if (list.data) {
      const l = list.data;
      if (l.length > 0) setLastDoc(l[l.length - 1]);
      setList(l);
    }
  };

  const handleSearchKeyDown = (e) => {
    if (e.keyCode === 13) handleSearch();
  };

  const req = async () => {
    try {
      setSearch("");
      if (
        table === "기부승인요청" ||
        table === "구매승인요청" ||
        table === "출고대기중"
      )
        setFilter("전체");
      else setFilter("");
      setLastDoc(null);
      const proms = await Promise.all([
        networkHandler.getApi(`${apiRoutes.INFO_GET}`),
        networkHandler.getApi(
          `${apiRoutes.UNIFORM_LIST}?status=${table || "기부승인요청"}`
        ),
      ]);
      console.log(proms[0]);
      setLocalInfo(proms[0]);
      setList(proms[1].data);
      if (proms[1].data.length > 0) {
        setLastDoc(proms[1].data[proms[1].data.length - 1]);
      }
      setLoading(false);
    } catch (err) {
      console.log(err);
    }
  };

  useEffect(() => {
    table === undefined ? Router.push("/?table=기부승인요청") : req();
  }, [table]);

  const clearList = () => {
    setList([]);
  };

  // useEffect(() => {
  //   window.addEventListener("scroll", handleScroll);
  //   () => window.removeEventListener("scroll", handleScroll);
  // }, []);

  const handleScroll = throttle(300, async () => {
    console.log(lastDoc);
    let queries = `?status=${table}`;
    if (search !== "") queries += `&keyword=${search}`;
    if (table === "기부승인요청") queries += `&giverDeliveryType=${filter}`;
    else if (table === "구매승인요청" || table === "출고대기중")
      queries += `&receiverDeliveryType=${filter}`;
    let list = await networkHandler.getApi(
      `${apiRoutes.UNIFORM_LIST}${queries}`
    );

    if (list.data) {
      //10개씩 skip하는 api 필요
      const l = list.data;
      if (l.length > 0) setLastDoc(l[l.length - 1]);
      setList(l);
    }
  });

  if (loading) return <LoadingPage />;

  return (
    <div>
      <Head>
        <title>대구 북구 교복 나누미 | 기부관리</title>
      </Head>
      <Nav />
      <div className={styles["home-wrapper"]}>
        <div className={styles["home-content-wrapper"]}>
          <div className={styles["home-heading"]}>교복 기부관리</div>
          <div className={styles["home-content-sorting-row"]}>
            <div>
              <Link href={`?table=기부승인요청`}>
                <a
                  className={
                    styles[
                      !table || table === "기부승인요청"
                        ? "table-filter-btn-active"
                        : "table-filter-btn-inactive"
                    ]
                  }
                  onClick={clearList}
                >
                  {localInfo === null
                    ? null
                    : `기부승인요청 ${localInfo.totalBeforeStock}`}
                </a>
              </Link>
              <Link href={`?table=교복보유중`}>
                <a
                  className={
                    styles[
                      table === "교복보유중"
                        ? "table-filter-btn-active"
                        : "table-filter-btn-inactive"
                    ]
                  }
                  onClick={clearList}
                >
                  {localInfo === null
                    ? null
                    : `교복보유중 ${localInfo.totalStock}`}
                </a>
              </Link>
              <Link href={`?table=구매승인요청`}>
                <a
                  className={
                    styles[
                      table === "구매승인요청"
                        ? "table-filter-btn-active"
                        : "table-filter-btn-inactive"
                    ]
                  }
                  onClick={clearList}
                >
                  {localInfo === null
                    ? null
                    : `구매승인요청 ${localInfo.totalBeforeShop}`}
                </a>
              </Link>
              <Link href={`?table=출고대기중`}>
                <a
                  className={
                    styles[
                      table === "출고대기중"
                        ? "table-filter-btn-active"
                        : "table-filter-btn-inactive"
                    ]
                  }
                  onClick={clearList}
                >
                  {localInfo === null
                    ? null
                    : `출고대기중 ${localInfo.totalBeforeDelivery}`}
                </a>
              </Link>
              <Link href={`?table=최종완료`}>
                <a
                  className={
                    styles[
                      table === "최종완료"
                        ? "table-filter-btn-active"
                        : "table-filter-btn-inactive"
                    ]
                  }
                  onClick={clearList}
                >
                  {localInfo === null
                    ? null
                    : `최종완료 ${localInfo.totalShopped}`}
                </a>
              </Link>
            </div>
          </div>
          <div className={styles["home-filter-wrapper"]}>
            <div className={styles["home-searchbar-wrapper"]}>
              <input
                value={search}
                onChange={({ target: { value } }) => setSearch(value)}
                onKeyDown={handleSearchKeyDown}
              />
              <button>
                <img src="/icon/search.png" onClick={handleSearch} />
              </button>
            </div>
            <CSVSaver csvData={list} fileName="filename" />
            {table === "기부승인요청" ? (
              <div className={styles["filter-row"]}>
                <button
                  className={styles["filter-item"]}
                  onClick={handleFilter("전체")}
                >
                  <div
                    className={
                      styles[filter === "전체" ? "active" : "inactive"]
                    }
                  >
                    <div />
                  </div>
                  전체
                </button>
                <button
                  className={styles["filter-item"]}
                  onClick={handleFilter("수거 요청")}
                >
                  <div
                    className={
                      styles[filter === "수거 요청" ? "active" : "inactive"]
                    }
                  >
                    <div />
                  </div>
                  수거 요청
                </button>
                <button
                  className={styles["filter-item"]}
                  onClick={handleFilter("봉사센터 방문")}
                >
                  <div
                    className={
                      styles[filter === "봉사센터 방문" ? "active" : "inactive"]
                    }
                  >
                    <div />
                  </div>
                  봉사센터 방문
                </button>
                <button
                  className={styles["filter-item"]}
                  onClick={handleFilter("복지센터 방문")}
                >
                  <div
                    className={
                      styles[filter === "복지센터 방문" ? "active" : "inactive"]
                    }
                  >
                    <div />
                  </div>
                  복지센터 방문
                </button>
              </div>
            ) : null}
            {table === "구매승인요청" || table === "출고대기중" ? (
              <div className={styles["filter-row"]}>
                <button
                  className={styles["filter-item"]}
                  onClick={handleFilter("전체")}
                >
                  <div
                    className={
                      styles[filter === "전체" ? "active" : "inactive"]
                    }
                  >
                    <div />
                  </div>
                  전체
                </button>
                <button
                  className={styles["filter-item"]}
                  onClick={handleFilter("배송 요청")}
                >
                  <div
                    className={
                      styles[filter === "배송 요청" ? "active" : "inactive"]
                    }
                  >
                    <div />
                  </div>
                  배송 요청
                </button>
                <button
                  className={styles["filter-item"]}
                  onClick={handleFilter("봉사센터 방문")}
                >
                  <div
                    className={
                      styles[filter === "봉사센터 방문" ? "active" : "inactive"]
                    }
                  >
                    <div />
                  </div>
                  직접 방문
                </button>
              </div>
            ) : null}
          </div>
          <div>
            {table === "기부승인요청" || !table ? (
              <BeforeStockTable list={list} />
            ) : null}
            {table === "교복보유중" ? <StockTable list={list} /> : null}
            {table === "구매승인요청" ? <BeforeShopTable list={list} /> : null}
            {table === "출고대기중" ? (
              <BeforeDeliveryTable list={list} />
            ) : null}
            {table === "최종완료" ? <ShoppedTable list={list} /> : null}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Home;
