import React from "react";

import { Route, Switch, BrowserRouter as Router } from "react-router-dom";
import { ToastContainer } from "react-toastify";

import Signup from "./components/Authentication/Signup";
import Dashboard from "./components/Dashboard";
import { CreateTask, EditTask, ShowTask } from "./components/Tasks";

const App = () => (
  <Router>
    <ToastContainer />
    <Switch>
      <Route exact component={Signup} path="/signup" />
      <Route exact component={ShowTask} path="/tasks/:slug/show" />
      <Route exact component={CreateTask} path="/tasks/create" />
      <Route exact component={EditTask} path="/tasks/:slug/edit" />
      <Route exact component={Dashboard} path="/dashboard" />
    </Switch>
  </Router>
);

export default App;
