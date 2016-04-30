import merge from 'lodash/merge';
import assign from 'lodash/assign';

import {
  RECEIVE_PROPS,
  REQUEST_PROPS,
  RECEIVE_USER_PROPS,
  REQUEST_USER_PROPS,
  RECEIVE_USER_GIVEN_PROPS,
  REQUEST_USER_GIVEN_PROPS,
} from '../constants/action-types';

function props(state = { user_given_props: {}, user_received_props: {}, props: {} }, action) {
  switch (action.type) {
  case RECEIVE_USER_GIVEN_PROPS:
    return merge({}, state, {
      user_given_props: action.props,
    });
  case RECEIVE_USER_PROPS:
    return merge({}, state, {
      user_received_props: action.props,
    });
  case RECEIVE_PROPS:
    return merge({}, state, {
      props: action.props,
    });
  case REQUEST_USER_GIVEN_PROPS:
    return assign({}, state, {
      user_given_props: {},
    });
  case REQUEST_USER_PROPS:
    return assign({}, state, {
      user_received_props: {},
    });
  case REQUEST_PROPS:
    return assign({}, state, {
      props: {},
    });
  default:
    return state;
  }
}

export default props;
