export default deleteUniform = async (id) => {
  networkHandler.deleteApi(apiRoutes.UNIFORM_PATH, id);
};
