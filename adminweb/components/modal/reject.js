import React, { useEffect, useState } from "react";

import styles from "styles/components/modal.module.scss";

const RejectModal = ({ closeModal, handleReject }) => {
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
        <div className={styles.heading1}>거절하기</div>
        <div className={styles.label1}>거절사유</div>
        <textarea placeholder="거절사유를 입력해주세요" onChange={({ target: { value } }) => setReject(value)} value={reject}/>
        <button onClick={() => handleReject(reject)}>거절</button>
      </div>
    </div>
  );
};

export default RejectModal;
