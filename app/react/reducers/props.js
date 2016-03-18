import merge from 'lodash/merge';
import {
  RECEIVE_USER_PROPS,
  REQUEST_USER_PROPS,
  RECEIVE_USER_GIVEN_PROPS,
  REQUEST_USER_GIVEN_PROPS,
} from '../constants/action-types';

function props(state = {user_given_props: {}, user_received_props: {}}, action) {
  switch (action.type) {
  case RECEIVE_USER_GIVEN_PROPS:
    return merge({}, state, {
      user_given_props: action.props,
    });
  case RECEIVE_USER_PROPS:
    return merge({}, state, {
      user_received_props: action.props,
    });
  case REQUEST_USER_GIVEN_PROPS:
    return Object.assign({}, state, {
      user_given_props: {},
    });
  case REQUEST_USER_PROPS:
    return Object.assign({}, state, {
      user_received_props: {},
    });
  default:
    return state;
  }
}

export default props;
