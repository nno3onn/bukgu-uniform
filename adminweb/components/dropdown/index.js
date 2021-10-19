import React, { useState } from "react";

import styles from "styles/components/dropdown.module.scss";
import { middleSchools, highSchools } from "configs/school";

const schools = middleSchools.concat(highSchools);
const clothType = {
  동복: ["자켓", "넥타이", "조끼", "셔츠", "바지", "치마"],
  하복: ["셔츠", "바지", "치마", "넥타이"],
  생활복: ["상의", "하의"],
  체육복: ["상의", "하의"],
};

export const getClothesTypes = (type) => {
  if (clothType[type]) return clothType[type];
  return [];
};

const Dropdown = ({
  type,
  value,
  handleValueChange,
  update = true,
  parentType = "체육복",
  index,
}) => {
  const [open, setOpen] = useState(false);

  const handleChange = (v) => () => {
    setOpen(false);
    if (type === "school") handleValueChange(v);
    if (type === "gender") handleValueChange(v);
    if (type === "season") handleValueChange(v);
    if (type === "cloth") handleValueChange(index, v);
  };

  return (
    <div className={styles[`dropdown-margin-${update}`]}>
      <button
        type="button"
        className={styles[`dropdown-wrapper-${type}`]}
        onClick={update ? () => setOpen(true) : undefined}
      >
        <div className={styles["dropdown-value"]}>{value}</div>
        {update ? (
          <img
            src="/icon/arrow-down.png"
            className={styles.arrow}
            alt="down-arrow"
          />
        ) : null}
      </button>
      {open ? (
        <div className={styles[`dropdown-contents-wrapper-${type}`]}>
          {type === "school" ? (
            <>
              <button
                type="button"
                onClick={handleChange(value)}
                className={styles["dropdown-contents-value"]}
              >
                <div>{value}</div>
                <img
                  alt="down-arrow"
                  src="/icon/arrow-up.png"
                  className={styles.arrow}
                />
              </button>
              {schools.map((school, i) => (
                <button
                  type="button"
                  key={String(i)}
                  onClick={handleChange(school)}
                >
                  {school}
                </button>
              ))}
            </>
          ) : null}
          {type === "gender" ? (
            <>
              <button
                type="button"
                onClick={handleChange(value)}
                className={styles["dropdown-contents-value"]}
              >
                <div>{value}</div>
                <img
                  alt="down-arrow"
                  src="/icon/arrow-up.png"
                  className={styles.arrow}
                />
              </button>
              <button type="button" onClick={handleChange("남자")}>
                남자
              </button>
              <button type="button" onClick={handleChange("여자")}>
                여자
              </button>
            </>
          ) : null}
          {type === "season" ? (
            <>
              <button
                type="button"
                onClick={handleChange(value)}
                className={styles["dropdown-contents-value"]}
              >
                <div>{value}</div>
                <img
                  alt="down-arrow"
                  src="/icon/arrow-up.png"
                  className={styles.arrow}
                />
              </button>
              <button type="button" onClick={handleChange("동복")}>
                동복
              </button>
              <button type="button" onClick={handleChange("하복")}>
                하복
              </button>
              <button type="button" onClick={handleChange("생활복")}>
                생활복
              </button>
              <button type="button" onClick={handleChange("체육복")}>
                체육복
              </button>
            </>
          ) : null}
          {type === "cloth" ? (
            <>
              <button
                type="button"
                onClick={handleChange(value)}
                className={styles["dropdown-contents-value"]}
              >
                <div>{value}</div>
                <img
                  alt="down-arrow"
                  src="/icon/arrow-up.png"
                  className={styles.arrow}
                />
              </button>
              {getClothesTypes(parentType).map((cloth, i) => (
                <button
                  type="button"
                  key={String(i)}
                  onClick={handleChange(cloth)}
                >
                  {cloth}
                </button>
              ))}
            </>
          ) : null}
        </div>
      ) : null}
    </div>
  );
};
// Dropdown.propTypes = {
//   type: PropTypes.string.isRequired,
// };
export default Dropdown;
