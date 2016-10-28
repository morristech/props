import React from 'react';
import { Router, Route, IndexRoute, browserHistory } from 'react-router';

import App from '../containers/App';
import PropsList from '../containers/PropsList';
import UsersList from '../components/UsersList';

export default (
  <Route path="/app" component={App}>
    <IndexRoute component={PropsList} />
    <Route path="users" component={UsersList} />
  </Route>
);
