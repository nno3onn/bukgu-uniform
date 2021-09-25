import React, { useEffect, useState } from "react";
import Head from "next/head";
import { useRouter } from "next/router";
import { Map, List, update } from "immutable";
import fetch from "node-fetch";

import onlyNum from "utils/onlyNum";
import networkHandler from "configs/networkHandler";
import apiRoutes from "configs/apiRoutes";
// import updateLocalInfo from "utils/updatelocalInfo";

import Nav from "components/nav";
import LoadingPage from "components/loading/page";
import RejectModal from "components/modal/reject";

import Dropdown, { getClothesTypes } from "components/dropdown";

import styles from "styles/pages/uniform.module.scss";

const Uniform = () => {
  const router = useRouter();
  const { id } = router.query;

  const [loading, setLoading] = useState(true);
  const [uniformInfo, setUniformInfo] = useState({});
  const [checkerGiverName, setCheckerGiverName] = useState("");
  const [checkerGiverBirth, setCheckerGiverBirth] = useState("");

  const [images, setImages] = useState(List([]));
  const [school, setSchool] = useState("");
  const [gender, setGender] = useState("");
  const [season, setSeason] = useState("");
  const [clothes, setClothes] = useState(List([]));

  const [logs, setLogs] = useState();

  const [rejectText, setRejectText] = useState("");
  const [rejectModalOpen, setRejectModalOpen] = useState(false);

  const req = async () => {
    try {
      const data = await networkHandler.getApi(
        `${apiRoutes.UNIFORM_GET}?uniformId=${id}`
      );

      console.log("uniformData:", data["data"]);
      if (data["data"]) {
        setUniformInfo(data["data"]);

        setImages(
          List(
            data["data"].images.map((img) => ({
              url: img,
              file: null,
            }))
          )
        );
        setSchool(data["data"]["filter-school"]);
        setGender(data["data"]["filter-gender"]);
        setSeason(data["data"]["filter-season"]);
        setClothes(
          List(
            data["data"].uniforms.map(({ clothType, size }) =>
              Map({ clothType, size })
            )
          )
        );
        setLoading(false);
        if (
          (data["data"].status === "구매승인요청" &&
            (!data["data"].receiverCert ||
              data["data"].receiverCert.length === 0)) ||
          data["data"].status === "출고대기중"
        ) {
          setCheckerGiverName(data["data"].receiverName);
          setCheckerGiverBirth(data["data"].receiverBirth);
        }
      } else {
        if (
          window.confirm(
            "해당하는 교복 정보가 존재하지 않습니다.\n이전 화면으로 가시겠습니까?"
          )
        ) {
          router.back();
        }
      }
    } catch (err) {
      console.log(err);
    }
  };

  useEffect(() => {
    req();
  }, []);

  const addImages = ({ target: { files } }) => {
    let _files = [];
    for (let i = 0; i < files.length; i++) {
      _files.push({ file: files[i], url: URL.createObjectURL(files[i]) });
    }
    if (_files.length !== 0) {
      setImages(images.concat(_files));
    }
  };

  const removeImg = (index) => () => {
    console.log("index:", index);
    console.log("removeImg-images", images);
    console.log("removeImg-remove index", images.remove(index));
    let yes;
    yes = window.confirm(
      "사진을 삭제하시겠습니까?\n하단에 변경사항저장까지 누르셔야 최종적용됩니다"
    );

    if (yes) {
      console.log("image.size:", images.size);
      setImages(images.size === 1 ? List([]) : images.remove(index));
      // console.log("remove image:", images);
    }
  };

  const handleSeason = (v) => {
    setSeason(v);
    const updater = () => getClothesTypes(v)[0];
    let c = clothes;
    for (let i = 0; i < clothes.size; i++)
      c = c.updateIn([i, "clothType"], updater);
    setClothes(c);
  };

  const handleClothChange = (index, value) => {
    setClothes(clothes.updateIn([index, "clothType"], () => value));
  };
  const handleSizeChange = (index, value) => {
    setClothes(clothes.updateIn([index, "size"], () => value));
  };
  const addCloth = () => {
    setClothes(
      clothes.push(Map({ clothType: getClothesTypes(season)[0], size: "" }))
    );
  };
  const removeCloth = (index) => () => {
    const yes = window.confirm(
      "옷을 삭제하시겠습니까?\n삭제하시고 최하단에 저장하기 까지 누르셔야 최종적용됩니다"
    );
    if (yes) {
      setClothes(clothes.remove(index));
    }
  };

  const handleUniformDelete = async () => {
    if (
      window.confirm(
        "정말로 교복정보를 삭제하시겠습니까?\n삭제후에는 복구하실 수 없습니다"
      )
    ) {
      let updateKey;
      if (uniformInfo.status === "기부승인요청") updateKey = "totalBeforeStock";
      if (uniformInfo.status === "교복보유중") updateKey = "totalStock";
      if (uniformInfo.status === "구매승인요청") updateKey = "totalBeforeShop";
      if (uniformInfo.status === "출고대기중")
        updateKey = "totalBeforeDelivery";
      if (uniformInfo.status === "최종완료") updateKey = "totalShopped";

      const updateData = {
        [updateKey]: -1,
      };

      if (uniformInfo.status === "교복보유중") {
        updateData["totalSchool"] = [
          uniformInfo["filter-school"].indexOf("고등") === -1
            ? "middleSchools"
            : "highSchools",
          uniformInfo["filter-school"],
          "totalStock",
          -1,
        ];
      }

      await Promise.all([
        networkHandler.getApi(`${apiRoutes.UNIFORM_DELETE}?uniformId=${id}`),
        networkHandler.postApi(
          `${apiRoutes.INFO_UPDATE}?uniformId=${id}`,
          updateData
        ),
      ]);
      router.back();
    }
  };

  const handleStockConfirm = async () => {
    if (
      window.confirm(
        "정말로 등록하시겠습니까?\n등록하시면 바로 앱에 유저들에게 교복이 노출됩니다"
      )
    ) {
      const imgs = await Promise.all(
        images.toJS().map(async ({ file, url }) => {
          if (!file) {
            return url;
          } else {
            const filename = `uploads/${
              uniformInfo.code
            }_${new Date().getTime()}.png`;

            const formData = new FormData();
            formData.append("imageFile", file, filename);

            fetch(apiRoutes.UPLOAD_PATH, {
              method: "POST",
              body: formData,
            })
              .then((response) => response.json())
              .catch((error) => console.error("Error:", error));
            return filename;
          }
        })
      );

      const fct = [];
      clothes.toJS().forEach(({ clothType }) => {
        if (fct.indexOf(clothType) === -1) fct.push(clothType);
      });

      const uniforms = clothes
        .toJS()
        .map((cloth) => ({ ...cloth, school, gender, season }));

      let title = `${gender} / ${season} - `;
      uniforms.map(
        (uniform) => (title += `${uniform.clothType} (사이즈: ${uniform.size})`)
      );

      const uniformData = {
        title,
        status: "교복보유중",
        images: imgs,
        "filter-gender": gender,
        "filter-school": school,
        "filter-season": season,
        "filter-clothType": fct,
        totalImages: imgs.length,
        uniforms,
        dateStock: new Date().getTime(),
      };

      const userLogData = {
        uniformId: id,
        showStatus: "기부완료",
      };

      const commonData = {
        totalBeforeStock: -1,
        totalStock: 1,
        totalSchool: [
          school.indexOf("고등") === -1 ? "middleSchools" : "highSchools",
          school,
          "totalStock",
          1,
        ],
      };

      const user = await networkHandler.getApi(
        `${apiRoutes.USER_GET}?targetUid=${uniformInfo["giverUid"]}`
      );
      console.log("user:", user);

      const userData = {
        total: user.alarms.total + 1,
        uniformDonate: user.alarms.uniformDonate + 1,
      };

      await Promise.all([
        networkHandler.putApi(
          `${apiRoutes.UNIFORM_UPDATE}?uniformId=${id}`,
          uniformData
        ),
        networkHandler.putApi(
          `${apiRoutes.UNIFORM_CONFIRM_DONATE}?uniformId=${id}`,
          {}
        ),
        networkHandler.putApi(
          `${apiRoutes.USER_LOGS_UNIFORM_DONATE_UPDATE}`,
          userLogData
        ),
        networkHandler.postApi(`${apiRoutes.INFO_UPDATE}`, commonData),
        networkHandler.putApi(
          `${apiRoutes.USER_UPDATE}?targetUid=${uniformInfo["giverUid"]}`,
          userData
        ),
      ]);
      router.back();
    }
  };

  const handleUpdate = async () => {
    console.log("handleUpdate");
    console.log("images:", images);
    console.log("images.size:", images.size);

    // const imgs =
    //   images.size === 0
    //     ? []
    //     : await Promise.all(images.toJS().map((a) => console.log(a)));

    const imgs = await Promise.all(
      images.map(async ({ file, url }) => {
        console.log("file:", file, "url:", url);
        if (!file) {
          return url;
        } else {
          const filename = `uploads/${
            uniformInfo.code
          }_${new Date().getTime()}.png`;

          const formData = new FormData();
          formData.append("imageFile", file, filename);

          fetch(apiRoutes.UPLOAD_PATH, {
            method: "POST",
            body: formData,
          })
            .then((response) => response.json())
            .catch((error) => console.error("Error:", error));
          return filename;
        }
      })
    );

    const fct = [];
    clothes.toJS().forEach(({ clothType }) => {
      if (fct.indexOf(clothType) === -1) fct.push(clothType);
    });

    const uniforms = clothes
      .toJS()
      .map((cloth) => ({ ...cloth, school, gender, season }));

    let title = `${gender} / ${season} - `;
    uniforms.map(
      (uniform) => (title += `${uniform.clothType} (사이즈: ${uniform.size})`)
    );

    const uniformData = {
      title,
      images: imgs,
      "filter-gender": gender,
      "filter-school": school,
      "filter-season": season,
      "filter-clothType": fct,
      totalImages: imgs.length,
      uniforms,
    };

    const futures = [
      networkHandler.putApi(
        `${apiRoutes.UNIFORM_UPDATE}?uniformId=${id}`,
        uniformData
      ),
    ];

    const commonData = {
      totalSchool: [
        school.indexOf("고등") === -1 ? "middleSchools" : "highSchools",
        school,
        "totalStock",
        1,
      ],
    };

    const commonData2 = {
      totalSchool: [
        uniformInfo["filter-school"].indexOf("고등") === -1
          ? "middleSchools"
          : "highSchools",
        uniformInfo["filter-school"],
        "totalStock",
        -1,
      ],
    };

    if (uniformInfo.status === "교복보유중") {
      futures.push(
        networkHandler.putApi(
          `${apiRoutes.UNIFORM_UPDATE}?uniformId=${id}`,
          uniformData
        ),
        networkHandler.postApi(`${apiRoutes.INFO_UPDATE}`, commonData),
        networkHandler.postApi(`${apiRoutes.INFO_UPDATE}`, commonData2)
      );
    }

    await Promise.all(futures);
    alert("수정사항이 반영되었습니다");
  };

  const searchLogs = async () => {
    console.log(
      "searchLogs:",
      `${apiRoutes.UNIFORM_SEARCH_RECORD}?nameKeyword=${checkerGiverName}&birthKeyword=${checkerGiverBirth}`
    );
    const logData = await networkHandler.getApi(
      `${apiRoutes.UNIFORM_SEARCH_RECORD}?nameKeyword=${checkerGiverName}&birthKeyword=${checkerGiverBirth}`
    );
    setLogs(logData["data"]);
  };

  const rejectShop = async (status, r) => {
    if (checkerGiverName === "" || checkerGiverBirth === "") {
      return alert("구매자 이름과 생년월일을 입력해주세요");
    } else {
      if (
        window.confirm(
          status === "구매승인요청"
            ? "정말로 거절하시겠습니까?\n거절된 교복은 다시 유저들에게 공개됩니다"
            : "정말로 반려하시겠습니까?\n반려된 교복은 다시 유저들에게 공개됩니다"
        )
      ) {
        const infoData =
          status === "구매승인요청"
            ? {
                // totalBeforeShop: -1,
                // totalStock: 1,
              }
            : {
                totalBeforeDelivery: -1,
                totalStock: 1,
              };

        const infoData2 = {
          totalSchool: [
            school.indexOf("고등") === -1 ? "middleSchools" : "highSchools",
            school,
            "totalStock",
            1,
          ],
        };
        console.log("status", status, "infoData:", infoData);

        const uniformData = {
          status: "교복보유중",
        };

        const userLogData = {
          uniformId: id,
          showStatus: status === "구매승인요청" ? "거절" : "반려",
          why: r,
        };

        const user = await networkHandler.getApi(
          `${apiRoutes.USER_GET}?targetUid=${uniformInfo["giverUid"]}`
        );
        const userData = {
          total: user.alarms.total + 1,
          uniformShop: user.alarms.uniformShop + 1,
        };

        const uniformTransferRecordData = {
          uid: uniformInfo.receiverUid,
          name: checkerGiverName,
          birth: checkerGiverBirth,
          school: school,
          cert: uniformInfo.receiverCert,
          season: season,
          gender: gender,
          uniforms: clothes.toJS().map((cloth) => ({ ...cloth })),
          confirm: "거절",
        };

        try {
          await Promise.all([
            networkHandler.putApi(
              `${apiRoutes.UNIFORM_REJECT_PURCHASE}?uniformId=${id}`,
              uniformTransferRecordData
            ),
            networkHandler.putApi(
              `${apiRoutes.USER_LOGS_UNIFORM_DONATE_UPDATE}`,
              userLogData
            ),
            networkHandler.putApi(
              `${apiRoutes.USER_UPDATE}?targetUid=${uniformInfo["giverUid"]}`,
              userData
            ),
            networkHandler.putApi(
              `${apiRoutes.UNIFORM_UPDATE}?uniformId=${uniformInfo["uniformId"]}`,
              uniformData
            ),
            networkHandler.postApi(`${apiRoutes.INFO_UPDATE}`, infoData),
            networkHandler.postApi(`${apiRoutes.INFO_UPDATE}`, infoData2),
          ]);
        } catch (err) {
          console.log(err);
        }
        router.back();
      }
    }
  };
  const confirmShop = async () => {
    if (checkerGiverName === "" || checkerGiverBirth === "") {
      return alert("구매자 이름과 생년월일을 입력해주세요");
    } else {
      if (window.confirm("구매승인을 하시겠습니까?")) {
        const userLogData = {
          uniformId: id,
          showStatus: `승인 - ${
            uniformInfo.receiverDeliveryType === "배송 요청"
              ? "배송예정"
              : "방문수령필요"
          }`,
        };

        const commonData = {
          totalSchool: [
            school.indexOf("고등") === -1 ? "middleSchools" : "highSchools",
            school,
            "totalStock",
            -1,
          ],
        };

        const commonData2 = {
          totalSchool: [
            school.indexOf("고등") === -1 ? "middleSchools" : "highSchools",
            school,
            "totalShop",
            1,
          ],
        };

        const user = await networkHandler.getApi(
          `${apiRoutes.USER_GET}?targetUid=${uniformInfo["giverUid"]}`
        );

        const userData = {
          total: user.alarms.total + 1,
          uniformShop: user.alarms.uniformShop + 1,
        };

        const uniformTransferRecordData = {
          uid: uniformInfo.receiverUid,
          name: checkerGiverName,
          birth: checkerGiverBirth,
          school: school,
          cert: uniformInfo.receiverCert,
          season: season,
          gender: gender,
          uniforms: clothes.toJS().map((cloth) => ({ ...cloth })),
          confirm: "승인",
        };

        try {
          await Promise.all([
            networkHandler.putApi(
              `${apiRoutes.UNIFORM_CONFIRM_PURCHASE}?uniformId=${id}`,
              uniformTransferRecordData
            ),
            networkHandler.putApi(
              `${apiRoutes.USER_LOGS_UNIFORM_DONATE_UPDATE}`,
              userLogData
            ),
            networkHandler.postApi(`${apiRoutes.INFO_UPDATE}`, commonData),
            networkHandler.postApi(`${apiRoutes.INFO_UPDATE}`, commonData2),
            networkHandler.putApi(
              `${apiRoutes.USER_UPDATE}?targetUid=${uniformInfo["giverUid"]}`,
              userData
            ),
          ]);
        } catch (err) {
          console.log(err);
        }
        router.back();
      }
    }
  };
  const confirmDelivery = async () => {
    if (window.confirm("교복전달을 완료하셨나요?")) {
      const userLogData = {
        uniformId: id,
        showStatus: "구매완료",
      };

      const commonData = {
        totalSchool: [
          school.indexOf("고등") === -1 ? "middleSchools" : "highSchools",
          school,
          "totalShop",
          -1,
        ],
      };

      const user = await networkHandler.getApi(
        `${apiRoutes.USER_GET}?targetUid=${uniformInfo["giverUid"]}`
      );

      const userData = {
        total: user.alarms.total + 1,
        uniformShop: user.alarms.uniformShop + 1,
      };

      try {
        await Promise.all([
          networkHandler.putApi(
            `${apiRoutes.UNIFORM_CONFIRM_DELIVERY}?uniformId=${id}`,
            {}
          ),
          networkHandler.putApi(
            `${apiRoutes.USER_LOGS_UNIFORM_DONATE_UPDATE}`,
            userLogData
          ),
          networkHandler.postApi(`${apiRoutes.INFO_UPDATE}`, commonData),
          networkHandler.putApi(
            `${apiRoutes.USER_UPDATE}?targetUid=${uniformInfo["giverUid"]}`,
            userData
          ),
        ]);
      } catch (err) {
        console.log(err);
      }
      router.back();
    }
  };

  if (loading) return <LoadingPage />;

  const d1 = new Date(uniformInfo.dateStock);
  const ds1 = `${d1.getFullYear()}. ${
    d1.getMonth() + 1 >= 10 ? d1.getMonth() + 1 : `0${d1.getMonth() + 1}`
  }. ${d1.getDate() >= 10 ? d1.getDate() : `0${d1.getDate()}`}`;
  return (
    <div>
      {rejectModalOpen ? (
        <RejectModal
          closeModal={() => setRejectModalOpen(false)}
          handleReject={rejectShop}
          status={uniformInfo.status}
        />
      ) : null}
      <Head>
        <title>대구 북구 교복 나누미 | 기부관리</title>
      </Head>
      <Nav />
      <div className={styles["uniform-wrapper"]}>
        <div className={styles["uniform-content-wrapper"]}>
          <div className={styles["uniform-heading-wrapper"]}>
            <div className={styles["uniform-heading"]}>
              <button
                className={styles["back-button"]}
                onClick={() => router.back()}
              >
                <img src="/icon/back.png" width="24px" height="24px" />
              </button>
              {uniformInfo.code}
            </div>
            <button
              className={styles["uniform-delete"]}
              onClick={handleUniformDelete}
            >
              삭제
            </button>
          </div>
          <div className={styles["uniform-label"]}>상세정보</div>
          <div className={styles["uniform-giver-table-wrapper"]}>
            <div className={styles["uniform-giver-table"]}>
              <div className={styles["row"]}>
                <div className={styles["col1"]}>기부자</div>
                <div className={styles["col2"]}>{uniformInfo.giverName}</div>
              </div>
              <div className={styles["row"]}>
                <div className={styles["col1"]}>연락처</div>
                <div
                  className={styles["col2"]}
                >{`${uniformInfo.giverPhone.substring(
                  0,
                  3
                )}-${uniformInfo.giverPhone.substring(
                  3,
                  7
                )}-${uniformInfo.giverPhone.substring(7, 11)}`}</div>
              </div>
              <div className={styles["row"]}>
                <div className={styles["col1"]}>수거 방법</div>
                <div className={styles["col2"]}>
                  {uniformInfo.giverDeliveryType}
                </div>
              </div>
              <div className={styles["row"]}>
                <div className={styles["col1"]}>
                  {uniformInfo.giverDeliveryType === "복지센터 방문"
                    ? "방문 복지센터"
                    : "주소"}
                </div>
                <div className={styles["col2"]}>
                  {uniformInfo.giverAddress || "-"}
                </div>
              </div>
              <div className={styles["row"]}>
                <div className={styles["col1"]}>기부 신청일</div>
                <div
                  className={styles["col2"]}
                >{`20${uniformInfo.code.substring(
                  0,
                  2
                )}. ${uniformInfo.code.substring(
                  2,
                  4
                )}. ${uniformInfo.code.substring(4, 6)}`}</div>
              </div>
              {uniformInfo.status !== "기부승인요청" ? (
                <div className={styles["row"]}>
                  <div className={styles["col1"]}>입고일</div>
                  <div className={styles["col2"]}>{ds1}</div>
                </div>
              ) : null}
              {uniformInfo.status === "기부승인요청" ||
              uniformInfo.status === "교복보유중" ? (
                <div className={styles["row"]}>
                  <div className={styles["col1"]}>현재 상태</div>
                  <div className={styles["col2-status"]}>
                    {uniformInfo.status}
                  </div>
                </div>
              ) : null}
            </div>
            {uniformInfo.status === "기부승인요청" ||
            uniformInfo.status === "교복보유중" ? null : (
              <div className={styles.margin24}>
                <div className={styles["uniform-giver-table"]}>
                  <div className={styles["row"]}>
                    <div className={styles["col1"]}>구매(희망)자</div>
                    <div className={styles["col2"]}>
                      {uniformInfo.receiverName}
                    </div>
                  </div>
                  <div className={styles["row"]}>
                    <div className={styles["col1"]}>연락처</div>
                    <div
                      className={styles["col2"]}
                    >{`${uniformInfo.receiverPhone.substring(
                      0,
                      3
                    )}-${uniformInfo.receiverPhone.substring(
                      3,
                      7
                    )}-${uniformInfo.receiverPhone.substring(7, 11)}`}</div>
                  </div>
                  <div className={styles["row"]}>
                    <div className={styles["col1"]}>주소</div>
                    <div className={styles["col2"]}>
                      {uniformInfo.receiverAddress || "-"}
                    </div>
                  </div>
                  <div className={styles["row"]}>
                    <div className={styles["col1"]}>수거 방법</div>
                    <div className={styles["col2"]}>
                      {uniformInfo.receiverDeliveryType}
                    </div>
                  </div>
                  <div className={styles["row"]}>
                    <div className={styles["col1"]}>구매 신청일</div>
                    <div className={styles["col2"]}>{uniformInfo.dateShop}</div>
                  </div>
                  <div className={styles["row"]}>
                    <div className={styles["col1"]}>현재 상태</div>
                    <div className={styles["col2-status"]}>
                      {uniformInfo.status}
                    </div>
                  </div>
                </div>
              </div>
            )}
          </div>
          <input
            type="file"
            id="imgs"
            accept="image/gif, image/jpeg, image/png"
            multiple
            onChange={addImages}
          />
          <div className={styles["uniform-label"]}>교복사진</div>
          <label className={styles.add} htmlFor="imgs">
            <img src="/icon/add.png" />
            사진 추가
          </label>
          <div className={styles["uniform-photos-wrapper"]}>
            {images.size === 0
              ? ""
              : images.map((image, i) => {
                  return image.url === null ? (
                    ""
                  ) : (
                    <div
                      key={String(i)}
                      className={
                        i % 4 === 3
                          ? styles["thumbnail-wrapper"]
                          : styles["thumbnail-wrapper-margin"]
                      }
                    >
                      <button
                        className={styles["thumbnails-bg"]}
                        onClick={removeImg(i)}
                      >
                        사진 삭제
                      </button>
                      <div
                        className={styles["thumbnails"]}
                        style={{
                          backgroundImage: `url(${
                            image.url.indexOf("uploads/") !== -1
                              ? networkHandler.getImageFromServer(image.url)
                              : image.url
                          })`,
                        }}
                      />
                    </div>
                  );
                })}
          </div>
          <div className={styles["uniform-label"]}>품목</div>
          <button onClick={addCloth}>
            <label className={styles.add}>
              <img src="/icon/add.png" />
              품목 추가
            </label>
          </button>
          <div className={styles["uniform-clothes-wrapper"]}>
            {clothes.map((cloth, i) => (
              <div className={styles["uniform-clothes-row"]} key={String(i)}>
                <div>
                  <div className={styles.dropdowns}>
                    <Dropdown
                      type="school"
                      value={school}
                      update={i === 0}
                      handleValueChange={setSchool}
                    />
                    <Dropdown
                      type="gender"
                      value={gender}
                      update={i === 0}
                      handleValueChange={setGender}
                    />
                    <Dropdown
                      type="season"
                      value={season}
                      update={i === 0}
                      handleValueChange={handleSeason}
                    />
                    <Dropdown
                      type="cloth"
                      parentType={season}
                      value={cloth.get("clothType")}
                      handleValueChange={handleClothChange}
                      index={i}
                    />
                  </div>
                  <input
                    className={styles["size-input"]}
                    value={cloth.get("size")}
                    onChange={({ target: { value } }) =>
                      handleSizeChange(i, value)
                    }
                  />
                </div>
                <button className={styles.delete} onClick={removeCloth(i)}>
                  <img src="/icon/close.png" />
                </button>
              </div>
            ))}
          </div>
          {uniformInfo.status !== "기부승인요청" &&
          uniformInfo.status !== "교복보유중" ? (
            <div className={styles["uniform-label-wrapper"]}>
              <div className={styles["uniform-label"]}>학생증</div>
              {!uniformInfo.receiverCert ||
              uniformInfo.receiverCert.length === 0 ? (
                <div className={styles["uniform-cert-none"]}>
                  올해 입학하는 학생입니다
                </div>
              ) : (
                <div className={styles["uniform-cert-wrapper"]}>
                  <div
                    style={{
                      backgroundImage: `url(${uniformInfo.receiverCert[0]})`,
                    }}
                  />
                  <div
                    style={{
                      backgroundImage: `url(${uniformInfo.receiverCert[1]})`,
                    }}
                  />
                </div>
              )}
            </div>
          ) : null}
          {uniformInfo.status === "구매승인요청" ? (
            <div className={styles["uniform-logs-wrapper"]}>
              <div className={styles["uniform-label2"]}>기록조회</div>
              <div className={styles["uniform-inner-label"]}>구매자 이름</div>
              <input
                className={styles["uniform-inner-input"]}
                value={checkerGiverName}
                onChange={({ target: { value } }) => setCheckerGiverName(value)}
              />
              <div className={styles["uniform-inner-label"]}>생년월일</div>
              <input
                className={styles["uniform-inner-input"]}
                placeholder="예: 20040101"
                value={checkerGiverBirth}
                onChange={({ target: { value } }) =>
                  setCheckerGiverBirth(onlyNum(value))
                }
                maxLength="8"
              />
              <button
                className={styles["uniform-inner-btn"]}
                onClick={searchLogs}
              >
                조회
              </button>
              {logs === null || logs === undefined ? null : (
                <div className={styles["uniform-inner-table"]}>
                  <div className={styles["heading-wrapper"]}>
                    <div className={styles.col1}>신청날짜</div>
                    <div className={styles.col2}>학교</div>
                    <div className={styles.col3}>신청품목</div>
                    <div className={styles.col4}>승인여부</div>
                  </div>
                  {logs.map((log, i) => {
                    console.log("logs(", i, "):", log);
                    const d = log.uniformId.split("-")[0];
                    const ds = `20${d.substring(0, 2)}. ${d.substring(
                      2,
                      4
                    )}. ${d.substring(4, 6)}`;
                    let item = `${log.gender} / ${log.season} / `;
                    log.uniforms.forEach(({ clothType }) => {
                      item += `${clothType},`;
                    });
                    return (
                      <div className={styles.row} key={String(i)}>
                        <div className={styles.col1}>{ds}</div>
                        <div className={styles.col2}>{log.school}</div>
                        <div className={styles.col3}>{item}</div>
                        <div className={styles.col4}>{log.confirm}</div>
                      </div>
                    );
                  })}
                </div>
              )}
            </div>
          ) : null}
          <div className={styles["uniform-btn-wrapper"]}>
            {uniformInfo.status === "교복보유중" ? (
              <button className={styles.update} onClick={handleUpdate}>
                변경사항 저장
              </button>
            ) : null}
            {uniformInfo.status === "구매승인요청" ? (
              <>
                <button
                  className={styles.reject}
                  onClick={() => setRejectModalOpen(true)}
                >
                  거절
                </button>{" "}
                <button className={styles.confirm} onClick={confirmShop}>
                  구매승인
                </button>
              </>
            ) : null}
            {uniformInfo.status === "기부승인요청" ? (
              <button className={styles.confirm} onClick={handleStockConfirm}>
                교복등록
              </button>
            ) : null}
            {uniformInfo.status === "출고대기중" ? (
              <>
                <button
                  className={styles.reject}
                  onClick={() => setRejectModalOpen(true)}
                >
                  반려하기
                </button>
                <button className={styles.confirm} onClick={confirmDelivery}>
                  교복전달완료
                </button>
              </>
            ) : null}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Uniform;
