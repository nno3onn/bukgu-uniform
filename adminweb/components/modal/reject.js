import React, { useEffect, useState } from "react";

import styles from "styles/components/modal.module.scss";

const RejectModal = ({ closeModal, handleReject, status }) => {
  const [reject, setReject] = useState("");

  return (
    <div className={styles["modal-wrapper"]}>
      <div className={styles["modal-row-end1"]}>
        <button className={styles["modal-close-wrapper"]} onClick={closeModal}>
          <img src="/icon/close-white.png" />
          <div>닫기</div>
        </button>
      </div>
      <div className={styles["modal-reject-contents"]}>
        <div className={styles.heading1}>
          {status === "구매승인요청" ? "거절하기" : "반려하기"}
        </div>
        <div className={styles.label1}>
          {status === "구매승인요청" ? "거절사유" : "반려사유"}
        </div>
        <textarea
          placeholder={
            status === "구매승인요청"
              ? "거절사유를 입력해주세요"
              : "반려사유를 입력해주세요"
          }
          onChange={({ target: { value } }) => setReject(value)}
          value={reject}
        />
        <button onClick={() => handleReject(reject)}>
          {status === "구매승인요청" ? "거절" : "반려"}
        </button>
      </div>
    </div>
  );
};

export default RejectModal;
