import merge from 'lodash/merge';
import assign from 'lodash/assign';

import {
  RECEIVE_USER_PROPS,
  REQUEST_USER_PROPS,
  RECEIVE_USER_GIVEN_PROPS,
  REQUEST_USER_GIVEN_PROPS,
} from '../constants/action-types';

const initialState = {
  user_given_props: {},
  user_received_props: {},
  given_props_request: true,
  received_props_request: true,
};

function props(state = initialState, action) {
  switch (action.type) {
    case RECEIVE_USER_GIVEN_PROPS:
      return merge({}, state, {
        user_given_props: action.props,
        given_props_request: false,
      });
    case RECEIVE_USER_PROPS:
      return merge({}, state, {
        user_received_props: action.props,
        received_props_request: false,
      });
    case REQUEST_USER_GIVEN_PROPS:
      return assign({}, state, {
        user_given_props: {},
        given_props_request: true,
      });
    case REQUEST_USER_PROPS:
      return assign({}, state, {
        user_received_props: {},
        received_props_request: true,
      });
    default:
      return state;
  }
}

export default props;
