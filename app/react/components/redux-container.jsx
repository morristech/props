import React from 'react';
import { Provider } from 'react-redux';
import { Router, Route, browserHistory } from 'react-router';
import { syncHistoryWithStore } from 'react-router-redux';
import configureStore from '../store/configure-store';

import UsersContainer from './users/users-container';
import UserPropsContainer from './user/user-props-container';

const store = configureStore();

const history = syncHistoryWithStore(browserHistory, store);

function reduxContainer() {
  return (
    <Provider store={store}>
      <Router history={history}>
        <Route path="/users" component={UsersContainer} />
        <Route path="/users/:userId" component={UserPropsContainer} />
      </Router>
    </Provider>
  );
}

export default reduxContainer;
