import React, { PropTypes } from 'react';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware, compose } from 'redux';
import thunkMiddleware from 'redux-thunk';
import rootReducer from '../reducers/index';

import UserPropsContainer from './user/user-props-container';

const applyDevTools = function applyDevTools() {
  if (process.env.NODE_ENV === 'development' && window.devToolsExtension) {
    return window.devToolsExtension();
  }
  return f => f;
};

const enhancer = compose(
  applyMiddleware(thunkMiddleware),
  applyDevTools(),
);

const store = createStore(
  rootReducer,
  {},
  enhancer
);

export default class ReduxContainer extends React.Component {
  static get propTypes() {
    return {
      userId: PropTypes.string.isRequired,
    };
  }

  render() {
    return (
      <div>
        <Provider store={store}>
          <UserPropsContainer userId={this.props.userId}/>
        </Provider>
      </div>
    );
  }
}
