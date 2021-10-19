import React, { useEffect, useRef } from "react";
import Head from "next/head";

import styles from "components/loading/page.module.scss";

const LoadingPage = () => {
  const imgRef = useRef();

  useEffect(() => {
    let index = 0;
    imgRef.current.src = `/img/loading${index + 1}.png`;
    const interval = setInterval(() => {
      index = (index + 1) % 8;
      imgRef.current.src = `/img/loading${index + 1}.png`;
    }, 300);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className={styles["loadingPage-wrapper"]}>
      <Head>
        <title>대구 북구 교복 나누미 | 로딩중..</title>
      </Head>
      <img alt="loading" ref={imgRef} />
    </div>
  );
};

export default LoadingPage;
