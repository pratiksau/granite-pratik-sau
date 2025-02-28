import axios from "axios";

const fetch = () => axios.get("/tasks");

const show = slug => axios.get(`/tasks/${slug}`);

const create = payload =>
  axios.post("/tasks", {
    task: payload,
  });

const tasksApi = {
  fetch,
  create,
  show,
};

export default tasksApi;
