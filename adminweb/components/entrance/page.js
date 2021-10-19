import React, { useState } from "react";
import Head from "next/head";
import { useRouter } from "next/router";

import styles from "components/entrance/page.module.scss";
import networkHandler from "configs/networkHandler";
import apiRoutes from "configs/apiRoutes";

import LoadingPage from "components/loading/page";

const EntrancePage = () => {
  const router = useRouter();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async () => {
    if (email.length === 0 || password.length === 0) {
      alert("모든 항목을 채워주세요");
      return;
    }

    try {
      setLoading(true);
      const data = await networkHandler.postApi(apiRoutes.ADMIN_SIGN_IN, {
        id: email,
        password,
      });

      if (data.success) {
        window.localStorage.setItem("x-access-token", data.token);
        router.reload();
      } else {
        alert(data.error ? data.error : "잠시 후 시도해주세요");
      }
    } catch (err) {
      console.log(err);
      setLoading(false);
    }
  };

  const handleKeyDown = ({ keyCode }) => {
    if (keyCode === 13) handleSubmit();
  };

  if (loading) return <LoadingPage />;
  return (
    <div className={styles["entrancePage-wrapper"]}>
      <Head>
        <title>대구 북구 교복 나누미 | 로그인</title>
      </Head>
      <img
        alt="bookie"
        src="/img/bookie.png"
        className={styles["entrancePage-bookie"]}
      />
      <div className={styles["entrancePage-title"]}>대구 북구 교복 나눔</div>
      <div className={styles["entrancePage-input-section"]}>
        <div className={styles["entrancePage-input-label"]}>이메일</div>
        <input
          className={styles["entrancePage-input"]}
          placeholder="이메일을 입력하세요"
          value={email}
          onChange={({ target: { value } }) => setEmail(value)}
        />
        <div className={styles["entrancePage-input-label"]}>비밀번호</div>
        <input
          className={styles["entrancePage-input"]}
          placeholder="비밀번호를 입력하세요"
          type="password"
          onKeyDown={handleKeyDown}
          value={password}
          onChange={({ target: { value } }) => setPassword(value)}
        />
        <button
          type="button"
          className={styles["entrancePage-sign-btn"]}
          onClick={handleSubmit}
        >
          로그인
        </button>
      </div>
    </div>
  );
};

export default EntrancePage;
