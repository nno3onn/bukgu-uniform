/* eslint-disable react/jsx-props-no-spreading */
/* eslint-disable react/prop-types */
import AuthHoC from "components/hocs/auth";

import "styles/globals.scss";

function MyApp({ Component, pageProps }) {
  return (
    <AuthHoC>
      <Component {...pageProps} />
    </AuthHoC>
  );
}

export default MyApp;
