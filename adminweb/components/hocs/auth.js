import React, { useState, useEffect } from "react";

// import firebase from "firebase/app";
// import "firebase/auth";

import LoadingPage from "components/loading/page";
import EntrancePage from "components/entrance/page";
import networkHandler from "configs/networkHandler";
import apiRoutes, { USER_PATH } from "configs/apiRoutes";

const AuthHoC = ({ children }) => {
  const [loading, setLoading] = useState(true);
  const [authentication, setAuthentication] = useState(false);

  useEffect(() => {
    const token = window.localStorage.getItem("x-access-token");

    if (token) {
      networkHandler
        .getApi(`${apiRoutes.ADMIN_VERIFY}`)
        .then(async (data) => {
          if (data.data.userType === "admin") {
            setAuthentication(true);

            const info = await networkHandler.getApi(apiRoutes.INFO_GET);
            window.localStorage.setItem("info", JSON.stringify(info));
          }
        })
        .catch((e) => {
          console.log(e);
        });
    }
    setLoading(false);
  }, []);

  if (loading) return <LoadingPage />;
  if (!authentication) return <EntrancePage />;

  return children;
};

export default AuthHoC;
