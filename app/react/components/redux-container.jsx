import React, { PropTypes } from 'react';
import { Provider } from 'react-redux';
import configureStore from '../store/configure-store';
import UserPropsContainer from './user/user-props-container';

const store = configureStore();

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
