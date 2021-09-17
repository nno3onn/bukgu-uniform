import React, { useState, useEffect } from "react";

import styles from "styles/components/dropdown.module.scss";

var schools = [
  "강북중학교",
  "경명여자중학교",
  "관음중학교",
  "관천중학교",
  "교동중학교",
  "구암중학교",
  "대구북중학교",
  "대구일중학교",
  "대구체육중학교",
  "동변중학교",
  "동평중학교",
  "매천중학교",
  "복현중학교",
  "사수중학교",
  "산격중학교",
  "서변중학교",
  "성광중학교",
  "성화중학교",
  "운암중학교",
  "칠곡중학교",
  "침산중학교",
  "팔달중학교",
  "학남중학교",
  "강북고등학교",
  "경명여자고등학교",
  "경상고등학교",
  "경상여자고등학교",
  "구암고등학교",
  "대구체육고등학교",
  "대중금속공업고등학교",
  "매천고등학교",
  "성광고등학교",
  "성화여자고등학교",
  "영송여자고등학교",
  "영진고등학교",
  "운암고등학교",
  "칠성고등학교",
  "학남고등학교",
  "함지고등학교",
];

export const getClothesTypes = (type) => {
  if (type === "동복") return ["자켓", "넥타이", "조끼", "셔츠", "바지", "치마"];
  else if (type === "하복") return ["셔츠", "바지", "치마", "넥타이"];
  else if (type === "생활복" || type === "체육복") return ["상의", "하의"];
  return [];
};

const Dropdown = ({ type, value, handleValueChange, update = true, parentType = "체육복", index }) => {
  const [open, setOpen] = useState(false);
  const [override, setOverride] = useState(0);

  const handleChange = (v) => () => {
    setOpen(false);
    if (type === "school") handleValueChange(v);
    if (type === "gender") handleValueChange(v);
    if (type === "season") handleValueChange(v);
    if (type === "cloth") handleValueChange(index, v);
  };

  return (
    <div className={styles[`dropdown-margin-${update}`]}>
      <button className={styles[`dropdown-wrapper-${type}`]} onClick={update ? () => setOpen(true) : undefined}>
        <div className={styles["dropdown-value"]}>{value}</div>
        { update ? <img src="/icon/arrow-down.png" className={styles.arrow} /> : null }
      </button>
      {
        open
          ? (
            <div className={styles[`dropdown-contents-wrapper-${type}`]}>
              {type === "school" ? <button onClick={handleChange(value)} className={styles["dropdown-contents-value"]}>
                <div>{value}</div>
                <img src="/icon/arrow-up.png" className={styles.arrow} />
              </button> : null}
              {type === "school" ? schools.map((school, i) => <button key={String(i)} onClick={handleChange(school)}>{school}</button>) : null}
              {type === "gender" ? <button onClick={handleChange(value)} className={styles["dropdown-contents-value"]}>
                <div>{value}</div>
                <img src="/icon/arrow-up.png" className={styles.arrow} />
              </button> : null}
              {type === "gender" ? <><button onClick={handleChange("남자")}>남자</button><button onClick={handleChange("여자")}>여자</button></> : null}
              {type === "season" ? <button onClick={handleChange(value)} className={styles["dropdown-contents-value"]}>
                <div>{value}</div>
                <img src="/icon/arrow-up.png" className={styles.arrow} />
              </button> : null}
              {type === "season" ? <><button onClick={handleChange("동복")}>동복</button><button onClick={handleChange("하복")}>하복</button><button onClick={handleChange("생활복")}>생활복</button><button onClick={handleChange("체육복")}>체육복</button></> : null}
              {type === "cloth" ? <button onClick={handleChange(value)} className={styles["dropdown-contents-value"]}>
                <div>{value}</div>
                <img src="/icon/arrow-up.png" className={styles.arrow} />
              </button> : null}
              {type === "cloth" ? getClothesTypes(parentType).map((cloth, i) => <button key={String(i)} onClick={handleChange(cloth)}>{cloth}</button>) : null}
            </div>
          )
          : null
      }
    </div>
  );
};

export default Dropdown;
